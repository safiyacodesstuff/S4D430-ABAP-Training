@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
define view entity ZR_06_MovieTP
  as select from ZI_06_Movie
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
      LastChangedBy
}
