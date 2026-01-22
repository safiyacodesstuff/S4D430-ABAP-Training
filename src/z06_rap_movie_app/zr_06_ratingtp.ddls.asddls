@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Rating'

@Metadata.ignorePropagatedAnnotations: true

define view entity ZR_06_RatingTP
  as select from ZI_06_Rating
     
  association        to parent ZR_06_MovieTP as _Movie on $projection.MovieUuid = _Movie.MovieUuid

{
  key RatingUuid,

      MovieUuid,
      UserName,
      Rating,
      RatingDate,

      /* Associations */
      _Movie
}
