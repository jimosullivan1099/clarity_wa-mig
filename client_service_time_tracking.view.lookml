- view: client_service_time_tracking
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: added
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension_group: last_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: ref_client_service
    type: int
    sql: ${TABLE}.ref_client_service

  - dimension: ref_date
    type: int
    sql: ${TABLE}.ref_date

  - dimension: ref_user_updated
    type: int
    sql: ${TABLE}.ref_user_updated

  - dimension: tracking_hour
    type: int
    sql: ${TABLE}.tracking_hour

  - dimension: tracking_minute
    type: int
    sql: ${TABLE}.tracking_minute

  - measure: count
    type: count
    drill_fields: [id]

