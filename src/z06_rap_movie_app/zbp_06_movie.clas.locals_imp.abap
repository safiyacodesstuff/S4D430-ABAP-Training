CLASS lhc_rating DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS DetermineRatingDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Rating~DetermineRatingDate.

    METHODS DetermineUserName FOR DETERMINE ON SAVE
      IMPORTING keys FOR Rating~DetermineUserName.

ENDCLASS.

CLASS lhc_rating IMPLEMENTATION.

  METHOD DetermineRatingDate.

    DATA ratings TYPE TABLE FOR UPDATE ZR_06_RatingTP.

    LOOP AT keys INTO DATA(key).
      APPEND VALUE #( %tky   = key-%tky
                      RatingDate = sy-datum ) TO ratings.
    ENDLOOP.

    MODIFY ENTITIES OF ZR_06_MovieTP IN LOCAL MODE
           ENTITY rating
           UPDATE
           FIELDS ( RatingDate )
           WITH ratings.

  ENDMETHOD.

  METHOD DetermineUserName.

  DATA ratings TYPE TABLE FOR UPDATE ZR_06_RatingTP.

    LOOP AT keys INTO DATA(key).
      APPEND VALUE #( %tky   = key-%tky
                      UserName = sy-uname ) TO ratings.
    ENDLOOP.

    MODIFY ENTITIES OF ZR_06_MovieTP IN LOCAL MODE
           ENTITY rating
           UPDATE
           FIELDS ( UserName )
           WITH ratings.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_Movie DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Movie RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Movie RESULT result.
    METHODS ValidateGenre FOR VALIDATE ON SAVE
      IMPORTING keys FOR Movie~ValidateGenre.

ENDCLASS.

CLASS lhc_Movie IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ValidateGenre.
    DATA movies TYPE TABLE FOR READ RESULT ZR_06_MovieTP.

    " Read Movies
    READ ENTITIES OF ZR_06_MovieTP IN LOCAL MODE
         ENTITY Movie
         FIELDS ( Genre )
         WITH CORRESPONDING #( keys )
         RESULT movies.

    " Process Movies
    LOOP AT movies INTO DATA(movie).

      " Validate Genres and Create Error Message
      SELECT SINGLE FROM zabap_movie_a
        FIELDS @abap_true
        WHERE genre = @movie-Genre
        INTO @DATA(exists).

      IF exists = abap_false.  " IF exists IS INITIAL.  " IF exists = ''.
        APPEND VALUE #( %tky = movie-%tky ) TO failed-movie.
        DATA(message) = NEW zcm_abap_movie( textid   = zcm_abap_movie=>no_genre_found
                                            genre    = movie-Genre
                                            severity = if_abap_behv_message=>severity-error ).

        APPEND VALUE #( %tky           = movie-%tky
                        %msg           = message
                        %element-Genre = if_abap_behv=>mk-on ) TO reported-movie.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
