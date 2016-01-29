- view: services
  fields:

  - dimension: id
    hidden: true
    type: int
    sql: ${TABLE}.id
    
  - dimension: service_id
    primary_key: true
    type: int
    sql: ${client_services.id}  
  

  - dimension: name
    bypass_suggest_restrictions: true
    sql: ${TABLE}.name

  - dimension: service_item_name
    sql: ${service_items.name}
    
  - dimension: service_item_id
    sql: ${service_items.id}
        
    
  - dimension: service_notes
    sql: ${client_service_notes.notes}  

  - dimension: start_date
    type: time
    timeframes: [time, date, week, month]
    sql: ${client_services.start_date}

    
  - measure: first_start
    label: First Start Date'
    type: date
    sql: |
      CASE
      WHEN MIN( COALESCE(${client_services.start_date},'1900-01-01')) = '1900-01-01' THEN
      NULL
      ELSE MIN( COALESCE(${client_services.start_date},'1900-01-01'))
      END   


  - dimension: end_date
    type: time
    timeframes: [time, date, week, month]
    sql: ${client_services.end_date}

  - dimension: ref_agency
    hidden: true
    type: int
    sql: ${TABLE}.ref_agency

  - dimension: ref_category
    label: 'Service Category'
    bypass_suggest_restrictions: true
    sql: fn_getPicklistValueName('service_categories',${TABLE}.ref_category)  


  - measure: count
    type: count



