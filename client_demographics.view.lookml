- view: client_demographics

  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: int
    sql: ${TABLE}.id

  - dimension: ethnicity
    type: int
    hidden: true
    sql: ${TABLE}.ethnicity
    
    
  - dimension: ethnicity_text
    label: 'Ethnicity'
    suggest: true
    bypass_suggest_restrictions: true
    sql: fn_getPicklistValueName('ethnicity',${ethnicity})    
      
  - dimension: name_middle
    label: 'Middle Name'
    sql: ${TABLE}.name_middle


  - dimension: gender
    type: int
    hidden: true
    sql: ${TABLE}.gender
    
  - dimension: gender_text
    label: 'Gender'
    sql: fn_getPicklistValueName('gender',${gender})
    bypass_suggest_restrictions: true


  - dimension: race
    type: int
    hidden: true
    sql: ${TABLE}.race
    
  - dimension: race_text
    label: 'Race'
    bypass_suggest_restrictions: true
    sql: fn_getPicklistValueName('race',${TABLE}.race)  

    
  - dimension: ref_agency
    hidden: true
    type: int
    sql: ${TABLE}.ref_agency

  - dimension: ref_client
    hidden: true
    type: int
    sql: ${TABLE}.ref_client

  - dimension: veteran
    hidden: true
    type: int
    sql: ${TABLE}.veteran
    
  - dimension: veteran_text
    label: 'Veteran Status'
    sql: fn_getPicklistValueName('veteran',${veteran})
    bypass_suggest_restrictions: true

  - dimension: veteran_branch
    type: int
    sql: ${TABLE}.veteran_branch

  - dimension: veteran_discharge
    type: int
    sql: ${TABLE}.veteran_discharge

  - dimension: veteran_duration
    type: int
    sql: ${TABLE}.veteran_duration

  - dimension: veteran_entered
    type: int
    sql: ${TABLE}.veteran_entered

  - dimension: veteran_era
    type: int
    sql: ${TABLE}.veteran_era

  - dimension: veteran_fire
    type: int
    sql: ${TABLE}.veteran_fire

  - dimension: veteran_separated
    type: int
    sql: ${TABLE}.veteran_separated

  - dimension: veteran_theater_afg
    type: int
    sql: ${TABLE}.veteran_theater_afg

  - dimension: veteran_theater_iraq1
    type: int
    sql: ${TABLE}.veteran_theater_iraq1

  - dimension: veteran_theater_iraq2
    type: int
    sql: ${TABLE}.veteran_theater_iraq2

  - dimension: veteran_theater_kw
    type: int
    sql: ${TABLE}.veteran_theater_kw

  - dimension: veteran_theater_other
    type: int
    sql: ${TABLE}.veteran_theater_other

  - dimension: veteran_theater_pg
    type: int
    sql: ${TABLE}.veteran_theater_pg

  - dimension: veteran_theater_vw
    type: int
    sql: ${TABLE}.veteran_theater_vw

  - dimension: veteran_theater_ww2
    type: int
    sql: ${TABLE}.veteran_theater_ww2

  - dimension: veteran_warzone
    type: int
    sql: ${TABLE}.veteran_warzone

  - dimension: veteran_warzone_duration
    type: int
    sql: ${TABLE}.veteran_warzone_duration

  - dimension: veteran_warzone_is
    type: int
    sql: ${TABLE}.veteran_warzone_is

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:


