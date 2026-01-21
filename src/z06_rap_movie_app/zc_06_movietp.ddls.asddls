@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_06_MovieTP
  as select from ZR_06_MovieTP
{
  key MovieUuid,
  
      @Search.fuzzinessThreshold: 0.7
      Title,
      
      @Search.defaultSearchElement: true
      Genre,
      
      @Search.defaultSearchElement: true
      PublishingYear,
      
      @Search.defaultSearchElement: true
      RuntimeInMin,
      
      @Semantics.imageUrl: true
      ImageUrl,
      
      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy
}
