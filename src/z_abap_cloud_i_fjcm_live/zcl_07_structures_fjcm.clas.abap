class zcl_07_structures_fjcm definition
  public
  final
  create public .

  public section.
    interfaces: if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class zcl_07_structures_fjcm implementation.

  method if_oo_adt_classrun~main.

    "STRUCTURE
    data: begin of ls_empl,
            name  type string,
            id    type i,
            email type /dmo/email_address,
          end of ls_empl.

    data: ls_employee  like ls_empl. "Crear estructuras utilizando tipos estructurados existentes

* With types
    types: begin of ty_empl,
             name  type string,
             id    type i,
             email type /dmo/email_address,
           end of ty_empl.

    data: ls_employee1 type ty_empl.

    ls_employee1 = value #( name = 'Pedro'
                            id = 1
                            email = 'pedro@logali.com' ).

    out->write( ls_employee1 ).

    data ls_flight type /dmo/flight.

    select single *
      from /dmo/flight
      where carrier_id = 'LH'
      into @ls_flight.

    out->write( data = ls_flight name = `Flight Reference Scenario` ).

*    Nested Structure   "Structura anidada*

    data: begin of ls_empl_info,

            begin of info,
              id         type i value 123456,
              first_name type string value `Laura`,
              last_name  type string value `Martínez`,
            end of info,

            begin of address,
              city    type string value `Frankfurt`,
              street  type string value `123 Main street`,
              country type string value `Germany`,
            end of address,

            begin of position,
              department type string value `IT`,
              salary     type p decimals 2 value `2000.25`,
            end of position,

          end of ls_empl_info.


    ls_empl_info = value #( info = value #( first_name = 'Ana'
                                           last_name  = 'García' )
                            address = value #( city = 'Madrid'
                                               street = 'Calle Mayor, 1'
                                               country = 'Spain' )
                            position = value #( department = 'HR'
                                                salary = '1800.50' ) ).

    out->write( data = ls_empl_info name = `ls_empl_info` ).



*    Deep structure  *Structura con tablas internas anidadas*

    "Creando el tipo estructurado para  la tabla interna anidada

    types: begin of ty_flights,
             flight_date   type /dmo/flight-flight_date,
             price         type /dmo/flight-price,
             currency_code type /dmo/flight-currency_code,
           end of ty_flights.

*    "Creando la estructura profunda (DEEP)

    data: begin of gs_flight,
            carrier    type /dmo/flight-carrier_id value 'AA',
            connid     type /dmo/flight-connection_id value '0018',
            lt_flights type table of ty_flights,
          end of gs_flight.

    "DEEP structure

    gs_flight = value #(
                carrier = 'SP' "spain
                connid  = '2024'
                lt_flights = value #( ( flight_date = '20250101'
                                      price = '150'
                                      currency_code = 'EUR' )
                                      ( flight_date = '20250101'
                                      price = '150'
                                      currency_code = 'EUR' ) ) ).

    select *
    from /dmo/flight
    where carrier_id = 'AA'
    into corresponding fields of table @gs_flight-lt_flights "el nombre de los campos debe ser igual
    up to 4 rows.

    "out->write( data = ls_flight name = `ls_flight` ).

    data: begin of ls_flight2,
            carrier    type /dmo/flight-carrier_id value 'AA',
            connid     type /dmo/flight-connection_id value '0018',
            ls_flights type ty_flights,
          end of ls_flight2.

    ls_flight2-carrier = 'LH'.
    ls_flight2-connid = '0001'.
    ls_flight2-ls_flights-currency_code = 'USD'.
    ls_flight2-ls_flights-flight_date = '20250523'.
    ls_flight2-ls_flights-price = '100.00'.

    out->write( data = ls_flight2 name = `ls_flight2` ).


    ls_flight2 = value #( carrier = 'AA'
                          connid  = '0002'
                          ls_flights-currency_code = 'EUR'
                          ls_flights-price = '200.00' ).

    out->write( data = ls_flight2 name = `ls_flight2` ).


    clear: ls_flight2-carrier.

    out->write( data = ls_flight2 name = `ls_flight2` ).

    clear: ls_flight2.

    out->write( data = ls_flight2 name = `ls_flight2` ).


    "NESTED Structure
    types: begin of purchase_order_type,
             order_id   type i,
             order_date type d,
           end of purchase_order_type,

           begin of supplier_type,
             supplier_id type i,
             name        type string,
           end of supplier_type,

           begin of material_type,
             material_id type i,
             name        type string,
           end of material_type.

    data ls_mat type material_type.

*******Include**** ***Mas usado y moderno*** *Poner alias para conflictos de nombres y sufijos

    types begin of invoice_type.
    include type purchase_order_type as purchase.
    include type supplier_type as supplier renaming with suffix _supplier.
    include structure ls_mat as mat renaming with suffix _mat.
    types end of invoice_type.

    data: ls_purchase type purchase_order_type,
          ls_invoice  type invoice_type.

    ls_purchase = value #( order_id = 1001
                           order_date = '20240501' ).

    ls_invoice = value #( purchase = ls_purchase
                           supplier = value #( supplier_id = 5001
                                               name = 'Tech Supplies Inc.' )
                           mat = value #( material_id = 3001
                                          name = 'Laptop' ) ).

    out->write( data = ls_invoice name = `ls_invoice` ).




  endmethod.

endclass..
