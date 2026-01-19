@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Demo 1: Projections'

@Metadata.ignorePropagatedAnnotations: true

define view entity Z06_Demo01       // Name der CDS VIew Entity (max. 30 Zeichen)
  as select from /dmo/connection

{
      /* Key Fields*/
  key carrier_id      as CarrierId,
  key connection_id   as ConnectionId,

      /* Fields*/
      airport_from_id as AirportFromId,
      airport_to_id   as AirportToId,
      distance        as Distance,
      distance_unit   as DistanceUnit
}
