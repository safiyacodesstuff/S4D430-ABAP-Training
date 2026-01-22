CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS ValidateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~ValidateCustomer.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ValidateCustomer.
    " SELECT FROM     READ ENTITY
    " FIELDS          FIELDS
    " WHERE           WITH
    " INTO            RESULT

    DATA travels TYPE TABLE FOR READ RESULT ZR_06_TravelTP.

    " Read Travels
    READ ENTITIES OF ZR_06_TravelTP IN LOCAL MODE
         ENTITY Travel
         FIELDS ( CustomerId )
         WITH CORRESPONDING #( keys )
         RESULT travels.

    " Process Travels
    LOOP AT travels INTO DATA(travel).
    ENDLOOP.

    " Validate Customer and Create Error Message
    SELECT SINGLE FROM /dmo/customer
      FIELDS @abap_true
      WHERE customer_id = @travel-CustomerId
      INTO @DATA(exists).

    IF exists = abap_false.  " IF exists IS INITIAL.  " IF exists = ''.
      APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
