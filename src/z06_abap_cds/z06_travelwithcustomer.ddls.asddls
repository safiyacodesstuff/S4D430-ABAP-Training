@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel with Customer'

define view entity Z06_TravelWithCustomer
  as select from Z06_Customer as c

    inner join   Z06_Travel   as t on t.CustomerId = c.CustomerId

{
  key t.TravelId,

      t.AgencyId,
      t.BeginDate,
      t.EndDate,
      t.BookingFee,
      t.TotalPrice,
      t.CurrencyCode,
      t.Description,
      t.Status,
      c.CustomerId,
      c.FirstName,
      c.LastName,
      c.Title,
      c.Street,
      c.PostalCode,
      c.City
}

where c.CountryCode = 'DE'
