@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer KPIs'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity Z06_CustomerKPIs
  as select from Z06_TravelWithCustomer as twc
{
  key CustomerId,
      CustomerName,
      Street,
      PostalCode,
      City,

      @EndUserText.label: 'Total Revenue'
      @EndUserText.quickInfo: 'Total Revenue'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum(TotalPrice + BookingFee)       as TotalRevenue,

      CurrencyCode,

      @EndUserText.label: 'Average Duration'
      @EndUserText.quickInfo: 'Average Duration'
      avg(Duration as abap.dec( 16, 2 )) as AverageDuration,

      @EndUserText.label: 'NumberOfDifferentAgencies'
      @EndUserText.quickInfo: 'NumberOfDifferentAgencies'
      count(distinct AgencyId)           as NumberOfDifferentAgencies

}
group by
  CustomerId,
  CustomerName,
  Street,
  PostalCode,
  City,
  CurrencyCode

having
  sum(TotalPrice + BookingFee) >= 5000
