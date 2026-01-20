CLASS zcl_06_abap_cds_07 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_06_abap_cds_07 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT FROM Z06_CustomerWithTravels
      FIELDS CustomerId,
             FirstName,
             LastName,
             Title,
             Street,
             PostalCode,
             City,
             \_Travels-Description,
             \_Travels-BeginDate,
             \_Travels-TotalPrice
      INTO TABLE @DATA(travels).

    out->write( travels ).
  ENDMETHOD.
ENDCLASS.
