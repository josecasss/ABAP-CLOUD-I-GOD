class zcl_09_internal_tab_typ_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_09_internal_tab_typ_fjcm implementation.


  method if_oo_adt_classrun~main.

    "Standard Table     *Keys are optional, duplicates allowed.
    data gt_flight_stan type table of /dmo/flight.  "Default is standard table.

    "Sorted table       *Must be Key mandatory to sort and can be non-unique
    data gt_flight_sort type sorted table of /dmo/flight with non-unique key carrier_id. " Order Table, allowing duplicates in field carrier_id

    "Hash table         *Super Fast searches, but just with unique key mandatory
    data gt_flight_hash type hashed table of /dmo/flight with unique key carrier_id. " Hash Table, not allowing duplicates in field carrier_id

  endmethod.
endclass.
