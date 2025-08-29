class zcl_lab_09_structure_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.

class zcl_lab_09_structure_fjcm implementation.


  method if_oo_adt_classrun~main.


*********Ejercicio 1***********

    types: begin of ty_flight,
             iduser    type c length 40,
             aircode   type /dmo/carrier_id,
             flightnum type /dmo/connection_id,
             key       type land1,
             seat      type /dmo/plane_seats_occupied,
             flighdate type /dmo/flight_date,
           end of ty_flight.

    types: begin of ty_airlines,
             carrid    type /dmo/carrier_id,
             connid    type /dmo/connection_id,
             countryfr type land1,
             cityfrom  type /dmo/city,
             airpfrom  type /dmo/airport_id,
             countryto type land1,
           end of ty_airlines.


********Ejercicio2******************

    types: begin of ty_nested,
            flights  type ty_flight,
            airlines type ty_airlines,
          end of ty_nested.

    data: ls_nested type ty_nested.

*********Ejercicio3******************

    types : begin of ty_deep,
             carrid  type /dmo/carrier_id,
             connid  type /dmo/connection_id,
             flights type ty_flight,
           end of ty_deep.

    data: ls_deep type ty_deep.

*********Ejercicio4******************

    ls_nested = value #( flights-iduser = 'USER01'
                         flights-aircode = 'AA'
                         flights-flightnum = '100'
                         flights-key = 'US'
                         flights-seat = 150
                         flights-flighdate = '20240615'
                         airlines-carrid = 'AA'
                         airlines-connid = '100'
                         airlines-countryfr = 'US'
                         airlines-cityfrom = 'JFK'
                         airlines-airpfrom = 'JFK'
                         airlines-countryto = 'ES'  ).


    ls_deep = value #( carrid = 'AA'
                       connid = '100'
                       flights = value #( iduser = 'USER01'
                                          aircode = 'AA'
                                          flightnum = '100'
                                          key = 'US'
                                          seat = 150
                                          flighdate = '20240615' ) ).

    out->write( data = ls_nested ).
    out->write( data = ls_deep ).



*********Ejercicio5******************


    types: begin of ty_include_flights,
            my_flight_info  type ty_flight,
            my_airline_info type ty_airlines,
          end of ty_include_flights.

    data: ls_include_flights type ty_include_flights.

    ls_include_flights = value #( my_flight_info-iduser = 'USER02'
                                   my_flight_info-aircode = 'DL'
                                   my_flight_info-flightnum = '250'
                                   my_flight_info-key = 'CA'
                                   my_flight_info-seat = 180
                                   my_flight_info-flighdate = '20240720'
                                   my_airline_info-carrid = 'DL'
                                   my_airline_info-connid = '250'
                                   my_airline_info-countryfr = 'CA'
                                   my_airline_info-cityfrom = 'LAX'
                                   my_airline_info-airpfrom = 'LAX'
                                   my_airline_info-countryto = 'MX' ).


*********Ejercicio6******************

    clear ls_nested.
    clear ls_deep.

    if ls_nested is initial and ls_deep is initial.
      out->write( 'Structures data have been cleaned' ).
    endif.


  endmethod.
endclass.
