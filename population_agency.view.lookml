
- view: population_agency
  derived_table:
#     sql_trigger_value: SELECT CURRENT_DATE()
    indexes: [first_entry_screen_id]
    sql: |
            SELECT
              cpd.ref_client
              ,cpd.ref_program
              ,cp.start_date
              ,cp.end_date
              ,dates.date
             
              ,min(
                case when screen_type = 2
                then cpd.id end)
                AS first_entry_screen_id
            
               ,max(
                case when screen_type = 3
                then cpd.id end)
                AS last_update_screen_id      
        
              ,max(
                case when screen_type = 4
                then cpd.id end)
                AS last_exit_screen_id
      
              
            FROM 
            {{ _access_filters["table_schema.name"]] }}.client_program_demographics cpd
            left join client_programs cp
                on cpd.ref_program = cp.id
                
            inner join ${dates.SQL_TABLE_NAME} dates
                    ON dates.date >= cp.start_date
                    AND (dates.date < cp.end_date OR cp.end_date IS NULL)
            where cp.ref_agency={{ _access_filters["agencies.id"]] }}
            
            GROUP BY 1,2,3,4,5
            

  fields:

  - measure: count_active_clients
    type: count
    drill_fields: detail*
    
  - measure: count_unique_active_clients
    type: count_distinct
    sql: ${ref_client}
    drill_fields: detail*    
    

  - dimension: ref_client
    type: number
    sql: ${TABLE}.ref_client
    
  - dimension: observation
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.date

  - dimension: ref_program
    type: number
    sql: ${TABLE}.ref_program

  - dimension: start_date
    sql: ${TABLE}.start_date

  - dimension: end_date
    sql: ${TABLE}.end_date

  - dimension: first_entry_screen_id
    type: number
    sql: ${TABLE}.first_entry_screen_id

  - dimension: last_exit_screen_id
    sql: ${TABLE}.last_exit_screen_id

  - dimension: last_update_screen_id
    type: int
    hidden: true
    sql: ${TABLE}.last_update_screen_id
    
  - dimension: last_screening_to_analyze
    type: int
    hidden: true
    sql: COALESCE(${last_exit_screen_id},${last_update_screen_id})

  sets:
    detail:
      - ref_client
      - ref_program
      - start_date
      - end_date
      - first_entry_screen_id
      - last_exit_screen_id

