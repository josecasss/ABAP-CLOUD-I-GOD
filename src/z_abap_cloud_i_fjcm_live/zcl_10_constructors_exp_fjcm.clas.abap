class zcl_10_constructors_exp_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_10_constructors_exp_fjcm implementation.


  method if_oo_adt_classrun~main.

**** VALUE
**Initialize a variable with VALUE
*
*    data(lt_msg) = value string_table( ( `Welcome` )
*                                       ( `Student` ) ).
*
*    data(lt_msg2) = value string_table( ( `Welcome` )
*                                        ( `Professor` ) ).
*
*    out->write( data = lt_msg name = 'lt_msg' ).
*
**Initializing again but with empty data *ITS NOT ADDING MORE DATA*
*    lt_msg = VALUE #( ).
*
*
*    out->write( data = lt_msg name = 'lt_msg' ).
*
**If i want to add more data I can use BASE to have a reference to the previous data and add, or insert-append with index*
*    lt_msg = value #( base lt_msg ( `to` ) ( `Peru` ) ).
*
*    out->write( data = lt_msg name = 'lt_msg' ).
*
**Posible fill nested structures with VALUE
*    data: begin of ls_emp_data,
*            emp_name type /dmo/first_name,
*            begin of address,
*              street type /dmo/street,
*              number type i,
*            end of address,
*          end of ls_emp_data.
*
*    ls_emp_data = value #( emp_name = 'Laura'
*                           address  = value #( street = 'Street CA'
*                                               number = 123  ) ).
*
*    out->write( ls_emp_data ).

*** CAST

*    TYPES: BEGIN OF t_struct,
*             col1 TYPE i,
*             col2 TYPE i,
*           END OF t_struct.
*
*    DATA: lo_data TYPE REF TO data, " Reference to a Generic Data
*          ls_int  TYPE t_struct.
*
*
*    lo_data = NEW t_struct( ). " Instance
*
*    ls_int = CAST t_struct( lo_data )->*. " Cast to the structure type
*
*    out->write( ls_int ).
*
*    out->write( cl_abap_char_utilities=>newline ).
*
*    ls_int = VALUE #( col1 = 4
*                      col2 = 6 ).
*
*    CAST t_struct( lo_data )->* = ls_int.

* REDUCE     *DO THE SAME AS COLLECT RECORDS(itab class) **BETTER PRACTICE JUST IN COMPLEX SCENARIOS**

    data: numbers type table of i,
          sum     type i.

    numbers = value #( ( 1 ) ( 2 ) ( 3 ) ).

    sum = reduce #( init x = 0         " Index from where start
                    for n in numbers   " Iteration
                    next x = x + n ).  " Operation, Possible make it complex

    out->write( sum ).

    out->write( cl_abap_char_utilities=>newline ).


* CORRESPONDING
    " Copy just the matching fields, the fields not matching will be empty or initial

    types: begin of ty_old,
             name type string,
             age  type i,
           end of ty_old.

    types: begin of ty_new,
             name    type string,
             age     type i,
             address type string, "Not matching field will be empty
           end of ty_new.

    data: old_data type ty_old.
*          new_data TYPE ty_new.

    old_data = value #( name = 'Alice' age = 25 ).

    data(new_data) = corresponding ty_new( old_data ).

    out->write( data = old_data name = 'Old Data' ).

    out->write( data = new_data name = 'New Data' ).

    out->write( cl_abap_char_utilities=>newline ).

*** REF

* Reference
*    DATA: lv_num  TYPE i,
*          ref_num TYPE REF TO i.
*
*    lv_num = 200.
*
*    ref_num = REF #( lv_num ). " Crear una referencia al valor de num
*
*    out->write( ref_num->* ). " Acceder al valor referenciado  ->* Means Reference to all
*
*    out->write( cl_abap_char_utilities=>newline ).

*** CONV
* Convert data types explicitly (Muste be compatibles)
    data: text type string,
          num  type p length 5 decimals 2 value '3.4'.

*    num = 100.

    text = conv string( num ).

    out->write( text ).


*** NEW

* Create an instance of a class
*    DATA(lo_class) = NEW zcl_01_test( ). "Inline declaration BETTER PRACTICE

*Other way to create an instance more explicit
*    DATA: lo_class2 TYPE REF TO zcl_01_test( ).

*    lo_class2 = NEW #( ).

*** Exact
*Make Stricts Validations in the conversion

*    DATA: lv_int_value  TYPE i VALUE 327678,
*          lv_int2_value TYPE int2.

** i and int2 have different ranges, so this conversion will fail
*    TRY.
*        lv_int2_value = EXACT int2( lv_int_value ).
*        out->write( data = lv_int2_value name = 'Converted value:' ).
*      CATCH cx_sy_conversion_error INTO DATA(lx_error).
*        out->write( data = lx_error->get_text( ) name = 'Error' ).
*    ENDTRY.

****Filter

    data: lt_flights_all   type standard table of /dmo/flight,
          lt_flights_final type standard table of /dmo/flight,
**Filter table   "The filter table must be sorted and have unique key table_line
          lt_filter        type sorted table of /dmo/flight-carrier_id with unique key table_line.

    select from /dmo/flight
        fields *
        into table @lt_flights_all.

    "Filter values   " Fill the filter table with the keys i need to filter
    lt_filter = value #( ( 'AA ' ) ( 'LH ' ) ( 'UA ' ) ).
    lt_flights_final =  filter #( lt_flights_all in lt_filter where carrier_id = table_line ) . "Table to be filter - Table filter - Condition
    out->write( lt_flights_all ).
    out->write( lt_flights_final ).

  endmethod.

endclass.

