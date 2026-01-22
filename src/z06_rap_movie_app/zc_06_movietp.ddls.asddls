@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Movie'

@Metadata.allowExtensions: true

@Search.searchable: true

define root view entity ZC_06_MovieTP
  as projection on ZR_06_MovieTP

{
  key MovieUuid,

      @Search.fuzzinessThreshold: 0.7
      Title,

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'GenreText' ]
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
      LastChangedBy,
      
      /* Transient Data */
      _AverageRating.AverageRating,
      _AverageRating.AverageRatingCriticality,
      _GenreText.GenreText,
      
      /* Associations */
      _Ratings : redirected to composition child ZC_06_RatingTP
}
