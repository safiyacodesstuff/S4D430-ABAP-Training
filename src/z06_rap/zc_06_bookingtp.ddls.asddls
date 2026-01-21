@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking'
define view entity ZC_06_BookingTP
  as projection on ZR_06_BookingTP
{
  key TravelId,
  key BookingId,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      
      /* Associations */
      _Travel: redirected to parent ZC_06_TravelTP
}
