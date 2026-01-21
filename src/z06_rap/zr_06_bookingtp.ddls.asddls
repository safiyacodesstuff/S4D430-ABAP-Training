@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Booking'

define view entity ZR_06_BookingTP
  as select from ZI_06_Booking

  association to parent ZR_06_TravelTP as _Travel on $projection.TravelId = _Travel.TravelId

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
      _Travel 
}
