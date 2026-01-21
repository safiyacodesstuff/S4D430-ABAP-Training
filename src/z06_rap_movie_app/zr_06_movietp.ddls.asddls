@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
define root view entity ZR_06_MovieTP
  as select from ZI_06_Movie
  
  composition [0..*] of ZR_06_RatingTP as _Ratings
{
  key MovieUuid,
      Title,
      Genre,
      PublishingYear,
      RuntimeInMin,
      ImageUrl,
      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy,
      
      /* Associations */
      _Ratings
}
