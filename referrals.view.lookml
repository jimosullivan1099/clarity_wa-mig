- view: referrals
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: added
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension_group: date
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date

  - dimension: days_pending
    type: int
    sql: ${TABLE}.days_pending

  - dimension: deleted
    type: int
    sql: ${TABLE}.deleted

  - dimension: denied_message
    type: string
    sql: ${TABLE}.denied_message

  - dimension: denied_reason
    type: int
    sql: ${TABLE}.denied_reason

  - dimension: in_progress
    type: int
    sql: ${TABLE}.in_progress

  - dimension_group: last_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: private
    type: int
    sql: ${TABLE}.private

  - dimension: queue
    type: int
    sql: ${TABLE}.queue

  - dimension: reassigned
    type: int
    sql: ${TABLE}.reassigned

  - dimension: ref_agency
    type: int
    sql: ${TABLE}.ref_agency

  - dimension: ref_agency_deleted
    type: int
    sql: ${TABLE}.ref_agency_deleted

  - dimension: ref_assessment
    type: int
    sql: ${TABLE}.ref_assessment

  - dimension: ref_client
    type: int
    sql: ${TABLE}.ref_client

  - dimension: ref_navigator
    type: int
    sql: ${TABLE}.ref_navigator

  - dimension: ref_opening
    type: int
    sql: ${TABLE}.ref_opening

  - dimension: ref_program
    type: int
    sql: ${TABLE}.ref_program

  - dimension: ref_user
    type: int
    sql: ${TABLE}.ref_user

  - dimension: ref_user_updated
    type: int
    sql: ${TABLE}.ref_user_updated

  - dimension: replaced_with
    type: int
    sql: ${TABLE}.replaced_with

  - dimension: status
    type: int
    sql: ${TABLE}.status

  - dimension: type
    type: int
    sql: ${TABLE}.type

  - measure: count
    type: count
    drill_fields: [id]

