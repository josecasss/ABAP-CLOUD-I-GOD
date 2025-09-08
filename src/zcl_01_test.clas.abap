class zcl_01_test definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class zcl_01_test implementation.




  method if_oo_adt_classrun~main.

      types: begin of ty_persona,
             name type string,
             age  type i,
             city type string,
           end of ty_persona.


    data(ls_personas) = value ty_persona( name = 'Alice' age = 30 city = 'New York' ).

    out->write( data = ls_personas name = 'Stucture' ).

  endmethod.

endclass.
