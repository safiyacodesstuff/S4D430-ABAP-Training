CLASS zcl_06_demo_09 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_06_demo_09 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT
      FROM Z06_Demo07( P_CarrierID = 'UA',
                       P_Deadline  = @sy-datum )
      FIELDS *
*    WHERE CarrierId = 'LH'
      INTO TABLE @DATA(flights).

    out->write( flights ).
  ENDMETHOD.
ENDCLASS.
