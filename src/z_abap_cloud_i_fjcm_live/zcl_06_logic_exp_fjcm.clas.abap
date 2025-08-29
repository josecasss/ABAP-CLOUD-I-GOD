class zcl_06_logic_exp_fjcm definition
  public
  final
  create public .

  public section.
    interfaces: if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class zcl_06_logic_exp_fjcm implementation.

  method if_oo_adt_classrun~main.

********IF/ENDIF************

*    data(lv_letra) = 'C'.
*
*    if lv_letra eq 'A'.
*      out->write( lv_letra ).
*
*    elseif lv_letra eq 'B'.               " Second condition
*      out->write( lv_letra ).
*
*    elseif lv_letra eq 'C'.               " Third condition
*      out->write( lv_letra ).
*
*    else.                                 " If none of the above conditions...
*      out->write( 'Unidentified.' ).
*    endif.
*
*
*
*    data(lv_num) = '3'.
*
*    if lv_num eq '3' or lv_letra eq 'B'.          "If its OR is enough that one condition is true " If its AND both conditions must be true
*      out->write( 'valid values' ).
*    endif.

** IF ANIDADOS                              " Nested If , if one condition is true, it goes to the next (:

*    data(lv_texto)  = 'ABAP'.
*    data(lv_texto2) = 'programming'.
*    data(lv_texto3) = 'classes'.
*
*    if lv_texto = 'ABAP'.
*      if lv_texto2 eq 'programming'.
*        if lv_texto3 = 'classes'.
*          out->write( 'Correct' ).
*        else.
*          out->write( 'Incorrect' ).
*        endif.
*      endif.
*    endif.
*
*    " VALOR INICIAL
*    clear lv_num.                              " Clear the variable, it will have its initial value
*
*    data: lv_char type c length 3.
*
*    if lv_num is initial.                      " Check if the variable is empty INITIAL   *Si no tiene valor...*
*      out->write( 'The Variable is empty' ).
*    endif.
*
*    if lv_char is not initial.                 " Check if the variable is not empty INITIAL    *Si tiene valor...*
*      out->write( 'The Variable is not empty' ).
*    else.
*      out->write( 'The Variable is empty' ).
*    endif.


** Case  "Similar to Switch but to evaluate conditions

*    data(lv_client) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )   " Random number between 1 and 3
*                                                  min  = 1
*                                                  max  = 3 )->get_next( ).
*
*    case lv_client.
*      when 1.
*        out->write( lv_client ).
*        out->write( 'Company client 1' ).
*      when 2.
*        out->write( lv_client ).
*        out->write( 'Company client 2' ).
*      when 3.
*        out->write( lv_client ).
*        out->write( 'Company client 3' ).
*      when others.
*        out->write( 'Client not registered in the database' ).
*    endcase.
*
*
*    case lv_letra.
*      when 'A'.
*        out->write( lv_letra ).
*      when 'B'.
*        out->write( lv_letra ).
*      when 'C'.
*        out->write( lv_letra ).
*      when others.
*        out->write( 'Unidentified.' ).
*    endcase.

*    do - enddo

*    do 5 times.                           " Repeat 5 times only that instruction
*      out->write( 'Master ABAP' ).
*    enddo.
*
*
*    "Another DO
*
*    data(lv_counter) = 1.
*
*    do.
*      out->write( 'Master ABAP' ).
*      if lv_counter = 10.                 " If the counter reaches 10, Exit the do
*        exit.
*      endif.
*      lv_counter += 1.
*    enddo.
*
**    check
*
*    do 20 times.
*      data(gv_resto) = sy-index mod 2.  " Sy-index is the counter of the iteration
*      check gv_resto = 0.
*      out->write( sy-index ).
*    enddo.


***  switch             "Its like Case, but this one is to assign values

*    do 6 times.
*
*      data(lv_value) = switch #( sy-index                                  " sy-index is the counter of iteration
*                                 when 1 then |Iteration 1|
*                                 when 2 then |Iteration 2|
*                                 when 3 then |Iteration 3|
*                                 else |# Iteration greater than 3 |  ).
*      out->write( lv_value ).
*
*    enddo.

***  Cond "Validate conditions and assign values

*    data(lv_get_time) = cl_abap_context_info=>get_system_time(  ).  " Class to get system time
*
*    data(lv_time) = cond #(
*                    when lv_get_time < '120000' then |{ lv_get_time time = iso } AM|
*                    when lv_get_time > '120000' then |{ conv t( lv_get_time - 12 * 3600 )  time = iso } PM|
*                    when lv_get_time = '120000' then |High Noon|
*                    else |Unidentified time| ).
*
*    out->write( lv_time ).

***While-endwhile

*    data: lv_num type i value 1.
*
*    "CLEAR lv_num.
*
*    while lv_num <= 10.                " While   *Mientras*
*
*      out->write(  |Número =  { lv_num }| ) .
*
*      lv_num += 1.
*
*      out->write( |# de iteración = { sy-index } | ).
*
*      if lv_num >= 5.
*        exit.
*      endif.
*
*    endwhile.

*loop - endloop            "Most Used to read internal tables

    select from /dmo/airport
    fields airport_id,
                 name
    into table @data(lt_table)  "Itab
    up to 50 rows.

    data(lv_count) = lines( lt_table ).

    loop at lt_table into data(ls_table).
      out->write( |{ ls_table-airport_id }-{ ls_table-name }| ).
    endloop.

    out->write( data = lv_count name = 'Total Records' ).

** Try-endtry *  Exception Handling

*  try.
*      data(lv_result) = 100 / 0.
*
*    catch cx_root into data(lx_exemp).               " Exception name = CX_SY_ZERODIVIDE
*      out->write( lx_exemp->get_text( ) ).           " Show the error message
*  endtry.
*
  endmethod.

endclass.
