class zcl_lab_07_tables_ii_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_lab_07_tables_ii_fjcm implementation.


  method if_oo_adt_classrun~main.

*Ejercicio 1

    types: begin of ty_flights,
             iduser     type c length 40,
             aircode    type /dmo/carrier_id,
             flightnum  type /dmo/connection_id,
             key        type land1,
             seat       type /dmo/plane_seats_occupied,
             flightdate type /dmo/flight_date,
           end of ty_flights.


*    data: lt_flights     type table of ty_flights,
*          lt_flights_info type table of ty_flights.
*
*    lt_flights = value #( for i = 1 until i > 15       "Condition
*                    ( iduser     = |1234{ sy-index }-t100437|
*                      aircode    = 'SQ'
*                      flightnum  =  0000 + i
*                      key        = | US |
*                      seat       =   0 + i
*                      flightdate =   cl_abap_context_info=>get_system_date( ) + i  ) ).
*
*    out->write( data = lt_flights name = 'lt_flights' ).
*
*    lt_flights_info = value #( for ls_flight in lt_flights ( "Ls_flight is the work area in lt_flights the itab
*                               iduser     = ls_flight-iduser "Mapping fields
*                               aircode    = 'CL'
*                               flightnum  = ls_flight-flightnum + 10
*                               key        = 'COP'
*                               seat       = ls_flight-seat
*                               flightdate = ls_flight-flightdate ) ).
*
*    out->write( data = lt_flights_info name = 'Info Flights' ).

*Ejercicio 2

    data: mt_flights_type type table of /dmo/flight,      "mt_ = member table
          mt_airline      type table of /dmo/connection,
          lt_final        type sorted table of ty_flights with non-unique key aircode.
*
    select *
    from /dmo/flight
    into table @mt_flights_type
    up to 10 rows.
*
*        out->write( data = mt_flights_type name = 'Type Flights' ).
*
*        lt_final = value #( for ls_flights_type in mt_flights_type where ( carrier_id = 'SQ' )
*                   for ls_airline in mt_airline where ( connection_id = ls_flights_type-connection_id ) " SQ connection_id
*                   ( iduser     = ls_flights_type-client
*                     aircode    = ls_flights_type-carrier_id
*                     flightnum  = ls_airline-connection_id
*                     key        = ls_airline-airport_from_id
*                     seat       = ls_flights_type-seats_occupied
*                     flightdate = ls_flights_type-flight_date ) ).

**Ejercicio 3
*
*
*    types: begin of ty_airlines,
*             carrier_id      type /dmo/carrier_id,
*             connection_id   type /dmo/connection_id,
*             airport_from_id type /dmo/airport_from_id,
*             airport_to_id   type /dmo/airport_to_id,
*           end of ty_airlines.
*
*    data : mt_airlines type table of ty_airlines.
*
*    select carrier_id, connection_id, airport_from_id, airport_to_id
*    from /dmo/connection
*    where airport_from_id = 'FRA'
*    into table @mt_airlines.
*
*    out->write( data = mt_airlines name = 'Airlines from FRA' ).
*
**Ejercicio 4
*
*
*    sort mt_airlines by connection_id descending.
*
*    out->write( data = mt_airlines name = 'Airlines - Connection Descending' ).
*
**Ejercicio 5
*
    data: mt_spfli type table of /dmo/connection.
*
*    select *
*    from /dmo/connection
*    where airport_from_id = 'FRA'
*    into table @mt_spfli
*    up to 10 rows.
*
*
*    loop at mt_spfli assigning field-symbol(<fs_spfli>).
*      if <fs_spfli>-departure_time > '12:00:00'.
*        <fs_spfli>-departure_time = cl_abap_context_info=>get_system_time( ).
*      endif.
*    endloop.
*    unassign <fs_spfli>.
*    out->write( data = mt_spfli name = 'Departure time changed' ).
*
**Ejercicio 6
*
*    delete mt_spfli where airport_from_id = 'FRA'.  "DELETE FROM * DATABASE TABLE* Delete *Itab*
*
*    out->write( data = mt_spfli name = 'Deleted FRA' ).

**Ejercicio 7

*    free mt_spfli.

*Ejercicio 8

    types: begin of ty_seats,
             carrier_id    type /dmo/carrier_id,
             connection_id type /dmo/connection_id,
             seats         type /dmo/plane_seats_occupied,
             bookings      type /dmo/flight_price,
           end of ty_seats.

    data: lt_seats   type hashed table of ty_seats with unique key carrier_id connection_id,
          lt_seats_2 type standard table of ty_seats.

    select carrier_id, connection_id, seats_occupied as seats, price as bookings
    from /dmo/flight
    where seats_max = 140
    into table @lt_seats.

    out->write( data = lt_seats name = 'lt_seats' ).

    select carrier_id, connection_id, seats_occupied as seats, price as bookings
    from /dmo/flight
    into table @lt_seats_2
    up to 5 rows.

    out->write( data = lt_seats_2 name = 'lt_seats_2' ).

    loop at lt_seats_2 into data(ls_seat).
      collect ls_seat into lt_seats.
    endloop.

    out->write( data = lt_seats name = 'Collected table' ).

*Ejercicio 9

*    data: mt_scarr type table of /dmo/carrier.
*
*    select *
*    from /dmo/flight
*    into table @mt_flights_type
*    up to 10 rows.
*
*    select *
*    from /dmo/carrier
*    into table @mt_scarr
*    up to 10 rows.
*
*
*    " Assigning values to variables in *memory* with LET . Similar like FOR
*    loop at mt_flights_type into data(ls_flight_let).
*      data(lv_flights) = conv string( let lv_airline_name = mt_scarr[ carrier_id = ls_flight_let-carrier_id ]-name
*                                          lv_flight_price = mt_flights_type[ carrier_id = ls_flight_let-carrier_id
*                                          connection_id = ls_flight_let-connection_id ]-price
*                                          lv_carrid       = mt_scarr[ carrier_id = ls_flight_let-carrier_id ]-carrier_id
*                                                            in | Airline ID: { lv_carrid } / Airline name: { lv_airline_name } / flight price: { lv_flight_price } | ).
*      exit.
*    endloop.
*    out->write( data = lv_flights name = 'Let data' ).

*Ejercicio 10

*    data: lt_flight_base type table of /dmo/flight.
*
*    lt_flight_base = value #( base mt_flights_type ( ) ).
*
*    out->write( data = lt_flight_base name = 'Base table' ).

*Ejercicio 11

    data: lt_members type standard table of /dmo/connection.

    select *
    from /dmo/connection
    into table @mt_spfli.

    loop at mt_spfli assigning field-symbol(<ls_spfli>)    " Field symbol
        group by <ls_spfli>-airport_from_id. " Grouping by airport_from_id column of groups
      clear lt_members.
      loop at group <ls_spfli> into data(ls_member).
        lt_members = value #( base lt_members ( ls_member ) ). "All in ls_member goes to lt_members
      endloop.
      out->write( data = lt_members name = 'lt_members' ).
    endloop.
    unassign <ls_spfli>.

*Ejercicio 12


    loop at mt_spfli assigning <ls_spfli>
      "Grouping by more than one column of groups
      group by ( airportfrom = <ls_spfli>-airport_from_id  " 2 keys to group
                 airportto   = <ls_spfli>-airport_to_id   ) into data(gs_key). " gs_key is a structure gonna be used like a key
      clear lt_members.
      loop at group gs_key into data(gs_member).
        lt_members = value #( base lt_members ( gs_member ) ). "All in gs_member goes to lt_members
      endloop.
      out->write( data = lt_members name = 'lt_members' ).
      out->write( data = gs_key name = 'gs_key' ).
    endloop.

*Ejercicio 13

    types lty_group_keys type standard table of /dmo/connection-carrier_id with empty key.

    out->write(  value lty_group_keys( for groups gv_group of gs_group in mt_spfli  "FOR groups variables in memory to group the itab
                                          group by gs_group-carrier_id
                                          ascending
                                          without members ( gv_group )  )  ).

*Ejercicio 14

    types lty_seats type range of /dmo/flight-seats_occupied.

    data(lt_range) = value lty_seats( ( sign = 'I'
                                        option = 'BT'
                                        low = 200
                                        high = 400 ) ).

    select * from /dmo/flight
    where seats_occupied in @lt_range
    into table @mt_flights_type.

    loop at mt_flights_type into data(ls_flight).
      out->write( data = ls_flight name = 'Range Tables' ).
    endloop.

*Ejercicio 15

    types: ty_currency type c length 8,
           begin of enum mty_currency base type ty_currency,
             c_initial value is initial, "0
             c_dollar  value 'USD',      "1
             c_euros   value 'EUR',      "2
             c_colpeso value 'COP',      "3
             c_mexpeso value 'MEX',      "4
           end of enum mty_currency.

    data: lv_currency type mty_currency.


    lv_currency = c_dollar.
    out->write( |Currency Code: { lv_currency }| ).

    lv_currency = c_euros.
    out->write( |Currency Code: { lv_currency }| ).

    data(lv_value) = lv_currency.

    out->write( lv_value ).

  endmethod.
endclass.
