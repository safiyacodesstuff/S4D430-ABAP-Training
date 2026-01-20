@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 4: Domain Fixed Values'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z06_Demo04
  as select from /dmo/travel                                                   as t
    inner join   DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: '/DMO/STATUS' ) as s // s für StatusText
    on  s.value_low = t.status
    and s.language  = $session.system_language
{
  key t.travel_id as TravelId,
      t.status    as Status,
      s.text      as StatusText

}
