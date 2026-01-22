@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Movie'

@Metadata.allowExtensions: true

@Search.searchable: true

define root view entity ZC_06_MovieTP
  provider contract transactional_query
  as projection on ZR_06_MovieTP

{
  key MovieUuid,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Title,
      
      @ObjectModel.text.element: [ 'GenreText' ]
      @Consumption.valueHelpDefinition: [{ entity: {name : 'ZI_06_GenreText', element: 'GenreText'} }]
      Genre,

      PublishingYear,
      RuntimeInMin,
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
