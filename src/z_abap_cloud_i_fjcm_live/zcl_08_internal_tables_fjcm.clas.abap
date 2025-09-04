class zcl_08_internal_tables_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun.

    types: begin of ty_employee,
             id     type i,
             email  type string,
             ape1   type string,
             ape2   type string,
             name   type string,
             fechan type d,
             fechaa type d,
           end of ty_employee,

           begin of ty_flights,
             iduser(40) type c,
             aircode    type /dmo/carrier_id,
             flightnum  type /dmo/connection_id,
             key        type land1,
             seat       type /dmo/plane_seats_occupied,
             flightdate type /dmo/flight_date,
           end of ty_flights,

           begin of ty_airlines,
             carrier_id      type /dmo/carrier_id,
             connection_id   type /dmo/connection_id,
             airport_from_id type /dmo/airport_from_id,
             airport_to_id   type /dmo/airport_to_id,
           end of ty_airlines,

           begin of ty_seats,
             carrier_id    type /dmo/carrier_id,
             connection_id type /dmo/connection_id,
             seats         type /dmo/plane_seats_occupied,
             bookings      type /dmo/flight_price,
           end of ty_seats,
********************************************************************
           begin of ty_range,
             sign(1)   type c,
             option(2) type c,
             low       type i,
             high      type i,
           end of ty_range.

    types: ty_currency type c length 8,
           begin of enum mty_currency base type ty_currency,
             c_initial value is initial, "0
             c_dollar  value 'USD',      "1
             c_euros   value 'EUR',      "2
             c_colpeso value 'COP',      "3
             c_mexpeso value 'MEX',      "4
           end of enum mty_currency.

    data: mt_employees    type table of ty_employee,
          mt_employees_2  type table of ty_employee,
          ms_employee     type ty_employee,
          mt_spfli        type table of /dmo/connection,
          ms_spfli        type /dmo/connection,
          ms_spfli_2      type /dmo/connection,
          mt_airlines     type standard table of /dmo/connection,
          mt_flights_type type standard table of /dmo/flight,
          mt_scarr        type standard table of /dmo/carrier.

    data gr_range type ty_range.

    data mt_airlines2 type standard table of ty_airlines.

    methods:
      add_records importing io_out type ref to if_oo_adt_classrun_out,
      insert_record importing io_out type ref to if_oo_adt_classrun_out,
      append_records importing io_out type ref to if_oo_adt_classrun_out,
      corresponding_example importing io_out type ref to if_oo_adt_classrun_out,
      read_table_with_key importing io_out type ref to if_oo_adt_classrun_out,
      check_records importing io_out type ref to if_oo_adt_classrun_out,
      get_record_index importing io_out type ref to if_oo_adt_classrun_out,
      loop_example importing io_out type ref to if_oo_adt_classrun_out.


    methods add_flights_with_for importing ir_out type ref to if_oo_adt_classrun_out.
    methods nested_for importing ir_out type ref to if_oo_adt_classrun_out.
    methods add_multiple_lines importing ir_out type ref to if_oo_adt_classrun_out.
    methods sort_records importing ir_out type ref to if_oo_adt_classrun_out.
    methods modify_records importing ir_out type ref to if_oo_adt_classrun_out.
    methods delete_records importing ir_out type ref to if_oo_adt_classrun_out.
    methods clear_free_memory importing ir_out type ref to if_oo_adt_classrun_out.
    methods collect_records importing ir_out type ref to if_oo_adt_classrun_out.
    methods use_let importing ir_out type ref to if_oo_adt_classrun_out.
    methods use_base importing ir_out type ref to if_oo_adt_classrun_out.
    methods group_records importing ir_out type ref to if_oo_adt_classrun_out.
    methods use_range_tables importing ir_out type ref to if_oo_adt_classrun_out.
    methods use_enumerations importing ir_out type ref to if_oo_adt_classrun_out.

  protected section.
  private section.
endclass.



class zcl_08_internal_tables_fjcm implementation.

  method if_oo_adt_classrun~main.

**    Add records
*    add_records( out ).
*
**    Insert records
*    insert_record( out ).
*
**    Adding records with append
*    append_records( out ).
*
*    Corresponding
*    corresponding_example( out ).
*
*    Read table with key
*   read_table_with_key( out ).
*
*    Checking records
*    check_records( out ).
*
*    Index of a record
*    get_record_index( out ).
*
*    Loop statement
*     loop_example( out ).
*
*******************Second part**************************************************
*   For
*    add_flights_with_for( out ).
*
*   For nested
*    nested_for( out ).
*
*    Add multiple lines (select)
*    add_multiple_lines( out ).
*
*    Sort records
    sort_records( out ).
*
*    Modify records
*    modify_records( out ).
*
*    Delete records
*    delete_records( out ).
*
*    Clear / free
*    clear_free_memory( out ).
*
*    Collect statement
*    collect_records( out ).
*
*    Let instruction
*    use_let( out ).

*    Base instruction
*    use_base( out ).
*
*    Grouping of records
*    group_records( out ).

*    Range tables
*    use_range_tables( out ).
*
*    Enumerations
*    use_enumerations( out ).

  endmethod.

  method add_flights_with_for.

    data: "ls_flight       TYPE ty_flights,
      lt_flights      type standard table of ty_flights,
      lt_flights_info type standard table of ty_flights.

    lt_flights = value #( for i = 1 until i > 15       "Condition
                        ( iduser     = |1234{ sy-index }-t100437|
                          aircode    = 'SQ'
                          flightnum  =  0000 + i
                          key        = | US |
                          seat       =   0 + i
                          flightdate =   cl_abap_context_info=>get_system_date( ) + i  ) ).

    ir_out->write( lt_flights ).

*    LOOP AT lt_flights INTO ls_flight. "Loop to modify data
*      ls_flight-aircode = 'CL'.
*      ls_flight-flightnum = ls_flight-flightnum + 10.
*      ls_flight-key = 'COP'.
*      APPEND ls_flight TO lt_flights_info. "Append the modify registers to another itab
*    ENDLOOP.

" Same as the loop above but with FOR
    lt_flights_info = value #( for ls_flight in lt_flights ( "Ls_flight is the work area in lt_flights the itab
                               iduser     = ls_flight-iduser "Mapping fields
                               aircode    = 'CL'
                               flightnum  = ls_flight-flightnum + 10
                               key        = 'COP'
                               seat       = ls_flight-seat
                               flightdate = ls_flight-flightdate ) ).

    ir_out->write( data = lt_flights_info name = 'For Table' ).

  endmethod.


  method add_multiple_lines.

    select carrier_id, connection_id, airport_from_id, airport_to_id "Adding just some fields
      from /dmo/connection
      where airport_from_id = 'FRA'
      into table @mt_airlines2.

    ir_out->write( data = mt_airlines2 name = 'Multiple lines' ).

  endmethod.


  method add_records.

*    adding records to internal tables

    "Constructor Value # *Better practice*
    me->mt_employees = value #( ( id     = 1
                                  email  = 'emp1@logali.com'
                                  ape1   = 'perez'
                                  ape2   = 'gomez'
                                  name   = 'juan'
                                  fechan = '19900101'
                                  fechaa = '20220101' ) ).

    "Other way to add records by mapping fields with append
    me->ms_employee-id = 2.
    me->ms_employee-email = 'emp2@logali.com'.
    me->ms_employee-ape1 = 'lopez'.
    me->ms_employee-ape2 = 'martinez'.
    me->ms_employee-name = 'ana'.
    me->ms_employee-fechan = '19920202'.
    me->ms_employee-fechaa = '20220202'.

    append me->ms_employee to me->mt_employees.

    io_out->write(  data = me->mt_employees name = 'Add records'  ).

  endmethod.


  method append_records. " IMPORTANT "

    me->ms_employee = value #( id = 5
                               email  = 'emp5@logali.com'
                               ape1   = 'torres'
                               ape2   = 'ruiz'
                               name   = 'carlos'
                               fechan = '19950505'
                               fechaa = '20220505' ).

    append me->ms_employee to me->mt_employees_2.

***Better practice****
*     adding a record a me->mt_employees_2 using append value
    append value #( id = 6
                    email = 'emp6@logali.com'
                    ape1 = 'hernandez'
                    ape2 = 'jimenez'
                    name = 'laura'
                    fechan = '19960606'
                    fechaa = '20220606' ) to me->mt_employees_2. "Different itab

*     adding lines index 2 to 3 from me->mt_employees to me->mt_employees_2
    append lines of me->mt_employees from 2 to 3 to me->mt_employees_2.  "APPEND always goes to the end of the itab

    io_out->write(  data = me->mt_employees_2 name = 'Add records with append lines' ).

  endmethod.


  method check_records.

*   flight consultation with connection_id older 0400
    select * from /dmo/connection where connection_id gt '0400'  order by connection_id ascending into table @me->mt_spfli.
    io_out->write( data = me->mt_spfli name = 'flight consultation with connection_id older 0400' ).

*New syntax
*   check if the flight exists 0407
    if line_exists( me->mt_spfli[ connection_id = '0407' ] ). "If line_exists checks
      io_out->write( |Flight 0407 exists| ).
    else.
      io_out->write( |Flight 0407 does not exist| ).
    endif.

*Old syntax
*    read table me->mt_spfli TRANSPORTING NO FIELDS with key connection_id = '0407'.
*
*    if sy-subrc = 0.
*
*    si existe
*
*    else.
*     no existe
*    endif.

  endmethod.


  method clear_free_memory.

    select * from /dmo/connection where carrier_id = 'SQ' into table @mt_airlines.

    clear mt_airlines.

    select * from /dmo/connection where carrier_id = 'SQ' into table @mt_airlines.

    free mt_airlines.

  endmethod.


  method collect_records.

    data: lt_seats   type hashed table of ty_seats with unique key carrier_id connection_id,
          lt_seats_2 type standard table of ty_seats.

    select distinct carrier_id, connection_id, seats_occupied as seats, price as bookings
      from /dmo/flight
      where seats_max eq '140'
      into table @lt_seats.

    select carrier_id, connection_id, seats_occupied as seats, price as bookings
      from /dmo/flight
      into table @lt_seats_2.

    loop at lt_seats_2 into data(ls_seat).
      collect ls_seat into lt_seats.
    endloop.

    ir_out->write( data = lt_seats name = 'Collect table' ).

  endmethod.


  method corresponding_example.

*   using move-corresponding to move data between structures
    select * from /dmo/connection
        where carrier_id eq 'LH'
        into table @mt_spfli.

    read table mt_spfli into me->ms_spfli index 2. " Reads the second record and inserts 2 register into the structure
**Same Read Table new syntax
    data(lv_airtport_to) = me->mt_spfli[ 1 ]-airport_to_id. "Reads the first record and the field airport_to_id
    data(ls_airtport_to) = me->mt_spfli[ 1 ]. "Reads the first record and all the fields Structure

* Old syntax
*    MOVE-CORRESPONDING me->ms_spfli TO me->ms_spfli_2.

*New syntax BETTER PRACTICE
    me->ms_spfli_2 = corresponding #( me->ms_spfli ). "Moves only the fields with the same name

    io_out->write( data = me->ms_spfli_2 name = 'Add records using move-corresponding' ).

    io_out->write( me->ms_spfli ).

    io_out->write( ls_airtport_to ).

    io_out->write( lv_airtport_to ).

  endmethod.


  method delete_records.

    select * from /dmo/connection where connection_id gt '0400' into table @me->mt_spfli.

    ir_out->write( data = mt_spfli name = 'Before Delete' ).

    delete mt_spfli where airport_to_id = 'FRA'.
    ir_out->write( data = mt_spfli name = 'Delete Records' ).

  endmethod.


  method get_record_index.
*     get index of flight 0407

    select * from /dmo/connection
    where connection_id gt '0400'
    into table @me->mt_spfli.

    io_out->write( data = me->mt_spfli ).

*Old syntax
*    read table me->mt_spfli with key connection_id = '0402' transporting no fields.
*    data(lv_index2) = sy-tabix. " Index of the record old syntax

*New syntax
    data(lv_index) = line_index( me->mt_spfli[ connection_id = '0407'  ]  ). " Index of the record with key connection_id = '0407'

    data(lv_lines) = lines( me->mt_spfli ). "Number of registers in the itab

    if sy-subrc = 0.
      io_out->write( |Flight index 0407: { lv_index }| ).
*      io_out->write( |Flight index 0402: { lv_index2 }| ).
      io_out->write( lv_lines ).
    else.
      io_out->write( 'Flight 0407 not found' ).
    endif.

  endmethod.


  method group_records.

    types lty_group_keys type standard table of /dmo/connection-carrier_id with empty key.
    data: lt_members type standard table of /dmo/connection.

    field-symbols <ls_spfli> type /dmo/connection.

    select * from /dmo/connection
*        WHERE carrier_id EQ 'LH'
        into table @mt_spfli.

*    Grouping of records
*    LOOP AT mt_spfli ASSIGNING <ls_spfli>
*        GROUP BY <ls_spfli>-airport_from_id.
*      CLEAR lt_members.
*      LOOP AT GROUP <ls_spfli> INTO DATA(ls_member).
*        lt_members = VALUE #( BASE lt_members ( ls_member ) ).
*      ENDLOOP.
*      ir_out->write( data = lt_members name = 'lt_members' ).
*    ENDLOOP.
*    UNASSIGN <ls_spfli>.

*    Grouping by key
*    LOOP AT mt_spfli ASSIGNING <ls_spfli>
*      "Grouping by more than one column of groups
*      GROUP BY ( airportfrom = <ls_spfli>-airport_from_id
*                 airportto   = <ls_spfli>-airport_to_id   ) INTO DATA(gs_key).
*      CLEAR lt_members.
*      LOOP AT GROUP gs_key INTO DATA(gs_member).
*        lt_members = VALUE #( BASE lt_members ( gs_member ) ).
*      ENDLOOP.
*      ir_out->write( data = lt_members name = 'lt_members' ).
*      ir_out->write( data = gs_key name = 'gs_key' ).
*    ENDLOOP.

*   FOR GROUPS
    ir_out->write(  value lty_group_keys( for groups gv_group of gs_group in mt_spfli
                                          group by gs_group-carrier_id
                                          ascending
                                          without members ( gv_group )  )  ).

  endmethod.


  method insert_record.

* Barely used in Real projects*************

*Fist to a structure and then to the internal table, and goes to the final position *NO ID Field*
    me->ms_employee-email = 'emp3@logali.com'.
    me->ms_employee-ape1 = 'Mejia'.
    me->ms_employee-ape2 = 'Casas'.
    me->ms_employee-name = 'José'.
    me->ms_employee-fechan = '19920205'.
    me->ms_employee-fechaa = '20220205'.

    insert me->ms_employee into table me->mt_employees.

    io_out->write(  data = me->mt_employees name = 'insert records'  ).

**Allows duplicates inserting depending on the table key definition

  endmethod.


  method loop_example.

***SUPER IMPORTANT USEFUL***
    select * from /dmo/connection where connection_id gt '0400' order by connection_id into table @me->mt_spfli.
    io_out->write( me->mt_spfli ).

*     loop through records with loop = 'KM'
    loop at me->mt_spfli into me->ms_spfli where airport_to_id = 'FRA'. "From 2 to 6 indexes
      io_out->write( me->ms_spfli ).
    endloop.

  endmethod.


  method modify_records.

    select * from /dmo/connection where connection_id gt '0400' into table @me->mt_spfli.

    ir_out->write( data = mt_spfli name = 'Before Modify' ).

    loop at mt_spfli into data(ls_spfli).
      if ls_spfli-departure_time gt '12:00:00'.
        ls_spfli-departure_time = cl_abap_context_info=>get_system_time(  ).
        modify mt_spfli from ls_spfli transporting departure_time.
      endif.
    endloop.
    ir_out->write( data = mt_spfli name = 'Modify table' ).

  endmethod.


  method nested_for.

    data: lt_final type sorted table of ty_flights with non-unique key aircode. "Sort Table with key aircode duplicates allowed

    select * from /dmo/flight into table @mt_flights_type.
    select * from /dmo/connection where carrier_id = 'SQ' into table @mt_airlines.

    lt_final = value #(  for ls_flights_type in mt_flights_type  where (  carrier_id = 'SQ' )  "1 First Condition
                             for ls_airline in mt_airlines where ( connection_id = ls_flights_type-connection_id ) " Connection_id = Connection_id del primer itab match
                       ( iduser = ls_flights_type-client
                         aircode = ls_flights_type-carrier_id
                         flightnum = ls_airline-connection_id
                         key = ls_airline-airport_from_id
                         seat = ls_flights_type-seats_occupied
                         flightdate = ls_flights_type-flight_date  )  ).

    ir_out->write( data = lt_final name = 'Nested For Table' ).

  endmethod.

  method read_table_with_key.

    select * from /dmo/connection
         where carrier_id eq 'LH'
         into table @mt_spfli.

*     read table with key to display departure city for destination airport 'FRA'
    read table me->mt_spfli into me->ms_spfli with key airport_to_id = 'FRA'.

*New syntax
    data(lv_airtport_to) = me->mt_spfli[ airport_from_id = 'JFK' ]-airport_to_id.   "Exception if not found ***[KEY]-Field***

    if sy-subrc = 0.
      io_out->write( |Departure city for FRA: { me->ms_spfli-airport_from_id }| ).
      io_out->write( lv_airtport_to ).
    endif.

  endmethod.


  method sort_records.

    select carrier_id, connection_id, airport_from_id, airport_to_id
      from /dmo/connection
      where airport_from_id = 'FRA'
      into table @mt_airlines2.

    sort mt_airlines2 by carrier_id ascending connection_id descending. " sorted by connection_id in descending order  *FIELD - ORDER*

    ir_out->write( mt_airlines2 ).

  endmethod.


  method use_base.

    data lt_flights_base type standard table of /dmo/flight.

    select * from /dmo/flight into table @mt_flights_type.

    ir_out->write( mt_flights_type ).

    lt_flights_base = value #( base mt_flights_type ( carrier_id    = 'DL'
                                                      connection_id    = '2500'
                                                      flight_date    = cl_abap_context_info=>get_system_date( )
                                                      price     = '2000'
                                                      currency_code  =  'USD'
                                                      plane_type_id =  'A380-800'
                                                      seats_max  =  120
                                                      seats_occupied  =  100      )
                                                      ( carrier_id    = 'DT'
                                                      connection_id    = '2500'
                                                      flight_date    = cl_abap_context_info=>get_system_date( )
                                                      price     = '2000'
                                                      currency_code  =  'USD'
                                                      plane_type_id =  'A380-800'
                                                      seats_max  =  120
                                                      seats_occupied  =  100      ) ).

    ir_out->write( data = lt_flights_base name = 'Flight Base Table' ).

  endmethod.


  method use_enumerations.

    data: lv_currency type mty_currency.

    lv_currency = c_dollar.
    ir_out->write( |Currency Code: { lv_currency }| ).

    lv_currency = c_euros.
    ir_out->write( |Currency Code: { lv_currency }| ).

    data(lv_value) = lv_currency.

    ir_out->write( lv_value ).


  endmethod.


  method use_let.

    select * from /dmo/flight into table @mt_flights_type.
    select * from /dmo/carrier into table @mt_scarr.

    loop at mt_flights_type into data(ls_flight_let).
      data(lv_flights) = conv string( let lv_airline_name = mt_scarr[ carrier_id = ls_flight_let-carrier_id ]-name
                                          lv_flight_price = mt_flights_type[ carrier_id = ls_flight_let-carrier_id
                                          connection_id = ls_flight_let-connection_id ]-price
                                          lv_carrid = mt_scarr[ carrier_id = ls_flight_let-carrier_id ]-carrier_id
                                      in | Airline ID: { lv_carrid } / Airline name: { lv_airline_name } / flight price: { lv_flight_price } | ).
      exit.
    endloop.
    ir_out->write( data = lv_flights name = 'Let data' ).

  endmethod.


  method use_range_tables.

    types lty_price type range of /dmo/flight-price.

    data(lt_range) = value lty_price(  ( sign   = 'I' "E
                                         option = 'BT' "EQ
                                         low    = '200'
                                         high   = '400'  )  ).

    select * from /dmo/flight
     where seats_occupied in @lt_range
      into table @mt_flights_type.

    loop at mt_flights_type into data(ls_flight).
      ir_out->write( data = ls_flight name = 'Range Tables' ).
    endloop.

  endmethod.

endclass.
