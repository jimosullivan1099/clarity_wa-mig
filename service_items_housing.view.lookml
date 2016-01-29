- view: service_items_housing
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: added
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension: allow_referred_reservations
    type: yesno
    sql: ${TABLE}.allow_referred_reservations

  - dimension: availability
    type: number
    sql: ${TABLE}.availability

  - dimension: beds_with_children
    type: int
    sql: ${TABLE}.beds_with_children

  - dimension: beds_wo_children
    type: int
    sql: ${TABLE}.beds_wo_children

  - dimension_group: information
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.information_date

  - dimension: inventory_type
    type: int
    sql: ${TABLE}.inventory_type

  - dimension_group: last_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: program_warning
    type: yesno
    sql: ${TABLE}.program_warning

  - dimension: ref_bed_type
    type: number
    sql: ${TABLE}.ref_bed_type

  - dimension: ref_household_type
    type: number
    sql: ${TABLE}.ref_household_type

  - dimension: ref_service_item
    type: int
    sql: ${TABLE}.ref_service_item

  - dimension: ref_service_type
    type: number
    sql: ${TABLE}.ref_service_type

  - dimension: ref_user_updated
    type: int
    sql: ${TABLE}.ref_user_updated

  - dimension: reservation
    type: yesno
    sql: ${TABLE}.reservation

  - dimension: reservation_term
    type: int
    sql: ${TABLE}.reservation_term

  - dimension: reservation_type
    type: yesno
    sql: ${TABLE}.reservation_type

  - dimension: units_with_children
    type: int
    sql: ${TABLE}.units_with_children

  - dimension: youth_inventory_type
    type: int
    sql: ${TABLE}.youth_inventory_type

  - measure: count
    type: count
    drill_fields: [id]

