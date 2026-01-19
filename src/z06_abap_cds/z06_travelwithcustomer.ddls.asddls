@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel with Customer'

define view entity Z06_TravelWithCustomer
  with parameters
    p_date : abap.dats

  as select from Z06_Customer as c

    inner join   Z06_Travel   as t on t.CustomerId = c.CustomerId

{
  key t.TravelId,

      t.AgencyId,

      t.BeginDate,
      t.EndDate,

      dats_days_between(t.BeginDate, t.EndDate)                as Duration,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.BookingFee,
                          source_currency    => t.CurrencyCode,
                          target_currency    => cast('EUR' as abap.cuky),
                          exchange_rate_date => $parameters.p_date,
                          error_handling     => 'SET_TO_NULL') as ConvertedBookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.TotalPrice,
                          source_currency    => t.CurrencyCode,
                          target_currency    => cast('EUR' as abap.cuky),
                          exchange_rate_date => $parameters.p_date,
                          error_handling     => 'SET_TO_NULL') as ConvertedTotalPrice,

      cast('EUR' as abap.cuky)                                 as CurrencyCode,

      t.Description,
      t.Status,

      case t.Status when 'P' then 'Planned'
                    when 'B' then 'Booked'
                    when 'N' then 'New'
                    when 'X' then 'Cancelled'
                    else 'Invalid Status!'
                    end                                        as StatusText,

      t.CustomerId,

      case when c.Title is not initial
        then concat_with_space(c.Title, concat_with_space(c.FirstName, c.LastName, 1), 1)
        else concat_with_space(c.FirstName, c.LastName, 1)
      end                                                      as CustomerName,

      c.Street,
      c.PostalCode,
      c.City
}

where c.CountryCode = 'DE'
