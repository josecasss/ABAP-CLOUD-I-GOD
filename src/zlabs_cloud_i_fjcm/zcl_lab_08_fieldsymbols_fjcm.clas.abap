class zcl_lab_08_fieldsymbols_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_lab_08_fieldsymbols_fjcm implementation.


  method if_oo_adt_classrun~main.

*Ejercicio 1

*    data: lv_employee type string value 'Freddy Casas'.
*
*    out->write( lv_employee ).
*
*    field-symbols <fs_employee> type string.
*
*    assign lv_employee to <fs_employee>.
*
*    <fs_employee> = 'José Casas Mejia'.
*
*    out->write( <fs_employee> ).

*Ejercicio 2

*    data: lt_employee2 type table of zemp_fjcm.

*    lt_employee2 = value #( for i = 1 until i > 15
*                          ( mandt = sy-mandt
*                            id =  cl_system_uuid=>create_uuid_x16_static( )
*                            first_name = 'Freddy'
*                            last_name = 'Casas'
*                            phone_number = '+1234567890'
*                            salary       = 50000 + i
*                            currency_code = 'USD' ) ).

*    out->write( lt_employee2 ).
*
*    Insert zemp_fjcm from table @lt_employee2.

******    field-symbols <ls_employee> type zemp_fjcm.
    select *
    from zemp_fjcm
    into table @data(lt_employee).

*    loop at lt_employee assigning field-symbol(<ls_employee>).
*      <ls_employee>-email = 'random@example.com'.
*    endloop.
*
*    out->write( lt_employee ).

*Ejercicio 3

*    append initial line to lt_employee assigning field-symbol(<ls_employee>).
*
*    if <ls_employee> is assigned.
*
*      <ls_employee> = value #( mandt = sy-mandt
*                            id =  cl_system_uuid=>create_uuid_x16_static( )
*                            first_name = 'JoséCa'
*                            last_name = 'Casas'
*                            phone_number = '+1234567890'
*                            salary       = 50000
*                            currency_code = 'USD'
*                            email = 'random@example.com' ).
*      out->write( lt_employee ).
*
*      insert zemp_fjcm from @<ls_employee>. "Insert the new record into the database
*
*      unassign <ls_employee>. " BETTER PRACTICE ALWYS AFTER stop using field symbols UNASSIGN to free memory
*
*    endif.

*Ejercicio 4

*    insert initial line into lt_employee assigning field-symbol(<ls_employee>) index 2.
*
*    if <ls_employee> is assigned.
*      out->write( lt_employee ).
*    else.
*      out->write( 'Field symbol UNASSIGNED' ).
*      unassign <ls_employee>. " BETTER PRACTICE ALWYS AFTER stop using field symbols UNASSIGN to free memory
*    endif.

*Ejercicio 5

    read table lt_employee assigning field-symbol(<ls_employee>) with key first_name = 'JoséCa'.
    out->write( <ls_employee> ).

    <ls_employee>-first_name = 'Pepe'.
    <ls_employee>-email = 'random@gmail.com'.

    out->write( <ls_employee> ).

    unassign <ls_employee>.

*Ejercicio 6

    field-symbols: <fs_date> type any.

    data(lv_date) = cl_abap_context_info=>get_system_date( ).

    assign lv_date to <fs_date> casting type d.

    if <fs_date> is assigned.
      out->write( |Today: { <fs_date> }| ).
    endif.





















  endmethod.
endclass.
