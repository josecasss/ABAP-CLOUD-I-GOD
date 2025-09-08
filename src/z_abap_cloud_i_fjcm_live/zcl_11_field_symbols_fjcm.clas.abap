class zcl_11_field_symbols_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_11_field_symbols_fjcm implementation.

  method if_oo_adt_classrun~main.

**FIELD SYMBOLS Pointing to memory area

*    DATA: gv_employee TYPE string.
*
**    FIELD-SYMBOLS <fs_employee> TYPE string. " Old syntax for field symbols
*
*    ASSIGN gv_employee TO FIELD-SYMBOL(<fs_employee>). "Inline syntax for field symbols BETTER PRACTICE
*
*    <fs_employee> = 'Laura'. " Modifying the memory area through the field symbol
*
*    out->write( <fs_employee> ).
*
*    <fs_employee> = 'José'.
*
*    out->write( <fs_employee> ).


    select from /dmo/flight
    fields *
     where carrier_id = 'AA'
     into table @data(lt_flights).

    out->write( lt_flights ).


*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>). " ALWAYS IN A LOOP do it with field symbols BETTER PRACTICE
*
*      <fs_flights>-currency_code = 'EUR'.
*      <fs_flights>-flight_date = cl_abap_context_info=>get_system_date( ).
*
*
*      out->write( |flight: { <fs_flights>-carrier_id }-{ <fs_flights>-connection_id }| ).
*
*    ENDLOOP.
*
*    out->write( lt_flights ).

**** Validation of FIELD-SYMBOL assignment

*    APPEND INITIAL LINE TO lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>).
*
*    IF <fs_flights> IS ASSIGNED.
*
*      out->write( <fs_flights> ).
*
*      UNASSIGN <fs_flights>. " BETTER PRACTICE ALWYS AFTER stop using field symbols UNASSIGN to free memory
*
*    ENDIF.

**** INSERT with field symbol "VALIDATION"
*    FIELD-SYMBOLS <fs_flights> TYPE /dmo/flight.
*
*    INSERT INITIAL LINE INTO lt_flights ASSIGNING <fs_flights> INDEX 1. " Insert a new line at index 1 and assign it to the field symbol
*
*    IF <fs_flights> IS ASSIGNED.
*
*      <fs_flights> = VALUE #( carrier_id = 'MX'
*                              connection_id = '0002'
*                              flight_date = '20250320'
*                              price = '3000'
*                              currency_code = 'MXN' ).
*
*      out->write( <fs_flights> ).
*
*    ELSE.
*
*      out->write( 'Field symbol UNASSIGNED' ).
*
*    ENDIF.

**** READ TABLE with field symbol

*    READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>) INDEX 1.
*
*    out->write( <fs_flights> ).
*
*    <fs_flights>-carrier_id = 'MX'. "Modifying the memory area through the field symbol
*    <fs_flights>-currency_code = 'MXN'.
*
*    out->write( <fs_flights> ).
*
*    UNASSIGN <fs_flights>.

**** CASTING with field symbols

    types: begin of ty_date,
             day   type n length 2,
             month type n length 2,
             year  type n length 4,
           end of ty_date.

    data: lv_date     type d.

*     Implicit casting of date type to a field symbol
    field-symbols: <lv_date>  type d,
                   <lv_date2> type any,
                   <lv_date3> type n.

    lv_date = cl_abap_context_info=>get_system_date( ).
    lv_date = lv_date+6(2) && lv_date+4(2) && lv_date+0(4).

    assign lv_date to <lv_date>.
    out->write( |Today's Date: { <lv_date> }| ).

    assign lv_date to <lv_date2> casting type ty_date.


    do.

      assign component sy-index of structure <lv_date2> to <lv_date3>.

      if sy-subrc <> 0.

        exit.

      endif.

      out->write( |Today's Date: { <lv_date3> }| ).

    enddo.














  endmethod.

endclass.
