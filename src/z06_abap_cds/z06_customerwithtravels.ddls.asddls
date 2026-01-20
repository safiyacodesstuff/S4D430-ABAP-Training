@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer with Travels'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z06_CustomerWithTravels
  as select from Z06_Customer

  association [0..*] to Z06_Travel as _Travels on $projection.CustomerId = _Travels.CustomerId

{
  key CustomerId,
      FirstName,
      LastName,
      Title,
      Street,
      PostalCode,
      City,
      CountryCode,

      /* Associations */
      _Travels
}
where
  CountryCode = 'DE'
