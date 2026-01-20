CLASS zcl_06_abap_cds_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_06_abap_cds_06 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT
      FROM Z06_CustomerKPIs( P_City = 'Schifferstadt' )
      FIELDS *
      INTO TABLE @DATA(customers).

      sort customers by TotalRevenue DESCENDING.

    out->write( customers ).
  ENDMETHOD.
ENDCLASS.
