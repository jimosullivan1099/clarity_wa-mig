- view: clients

  fields:

  - dimension: id
    label: 'Personal Id'
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: id_with_profile_link
    label: 'Personal Id with Profile Link'
    sql: ${TABLE}.id
    html: |
      {{ linked_value }}
      <a href=https://{{ _access_filters["site.name"]] }}.clarityhs.com/clients/{{ value }}/profile target=_new> [Profile]</a>


  - dimension_group: added
    label: 'Date Created'
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension: alias
    sql: ${TABLE}.alias

  - dimension_group: birth
    label: 'Date of Birth'
    type: time
    timeframes: [date, week, month, year]
    convert_tz: false
    sql: ${TABLE}.birth_date
    
  - dimension: age
    label: 'Current Age'
    description: ' This is the age of the client as of when this report was last run'
    type: number
    sql: YEAR(NOW()) - YEAR(${birth_date}) - (DATE_FORMAT(NOW(), '%m%d') < DATE_FORMAT(${birth_date}, '%m%d'))

  - dimension: age_tier
    type: tier
    style: integer
    tiers: [0,18,25,35,45,55,65]
    suggest: true
    sql: ${age}
    
  - measure: average_age
    type: average
    sql: ${age}

  - dimension: dob_quality
    type: hidden
    type: int
    sql: ${TABLE}.dob_quality

  - dimension: first_name
    sql: ${TABLE}.first_name

  - dimension: fl_private
    hidden: true
    type: yesno
    sql: ${TABLE}.fl_private

  - dimension: image
    hidden: true
    type: yesno
    sql: ${TABLE}.image

  - dimension: last_name
    label: 'Last Name'
    sql: ${TABLE}.last_name
    
  - dimension: full_name
    label: 'Client Full Name'
    sql: CONCAT(${first_name},' ',${last_name})
    required_fields: [id]



  - dimension_group: last_updated
    label: 'Date Updated'
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: name_quality
    hidden: true
    type: int
    sql: ${TABLE}.name_quality

  - dimension: ref_agency_created
    hidden: true
    type: int
    sql: ${TABLE}.ref_agency_created

  - dimension: ref_user_updated
    hidden: true
    type: int
    sql: ${TABLE}.ref_user_updated

  - dimension: ssn
    hidden: true
    sql: ${TABLE}.ssn

  - dimension: ssn1
    hidden: true
    sql: ${TABLE}.ssn1

  - dimension: ssn2
    hidden: true
    sql: ${TABLE}.ssn2

  - dimension: ssn3
    label: 'Last 4 SSN'
    sql: ${TABLE}.ssn3

  - dimension: ssn_quality
    hidden: true
    type: int
    sql: ${TABLE}.ssn_quality

  - dimension: unique_identifier
    sql: ${TABLE}.unique_identifier

  - measure: count
    label: 'Number of Clients'
    type: count_distinct
    drill_fields: detail*
    sql: ${TABLE}.id

    



# SETS #

  sets:
    detail:
      - clients.id
      - id_with_profile_link
      - clients.full_name
      - clients.age
      - programs.name
      - client_programs.start_date
      - client_programs.end_date

