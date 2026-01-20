@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel with Customer'

define view entity Z06_TravelWithCustomer
  as select from Z06_Customer                     as c

    inner join   Z06_Travel                       as t
      on t.CustomerId = c.CustomerId

    inner join   DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                   p_domain_name : '/DMO/STATUS') as s // s für StatusText
      on  s.value_low = t.Status
      and s.language  = $session.system_language

{
  key t.TravelId,

      t.AgencyId,

      t.BeginDate,
      t.EndDate,

      @EndUserText.label: 'Duration'
      @EndUserText.quickInfo: 'Duration'
      dats_days_between(t.BeginDate, t.EndDate) + 1            as Duration,

      @EndUserText.label: 'Booking Fee'
      @EndUserText.quickInfo: 'Booking Fee'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.BookingFee,
                          source_currency    => t.CurrencyCode,
                          target_currency    => cast('EUR' as abap.cuky),
                          exchange_rate_date => $session.system_date,
                          error_handling     => 'SET_TO_NULL') as BookingFee,

      @EndUserText.label: 'Total Price'
      @EndUserText.quickInfo: 'Total Price'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(amount             => t.TotalPrice,
                          source_currency    => t.CurrencyCode,
                          target_currency    => cast('EUR' as abap.cuky),
                          exchange_rate_date => $session.system_date,
                          error_handling     => 'SET_TO_NULL') as TotalPrice,

      cast('EUR' as /dmo/currency_code)                        as CurrencyCode,

      t.Description,

      @EndUserText.label: 'Status Text'
      @EndUserText.quickInfo: 'Status Text'
      s.text                                                   as StatusText,

      t.CustomerId,

      @EndUserText.label: 'Customer Name'
      @EndUserText.quickInfo: 'Customer Name'
      case when c.Title is not initial
        then concat_with_space(c.Title, concat_with_space(c.FirstName, c.LastName, 1), 1)
        else concat_with_space(c.FirstName, c.LastName, 1)
      end                                                      as CustomerName,

      c.Street,
      c.PostalCode,
      c.City
}

where c.CountryCode = 'DE'
