

- explore: base
  from: client_program_screening_base
  persist_for: 60 minutes
  label: 'HMIS Performance'
  conditionally_filter: 
    enrollments.start_date: 'before today'
    enrollments.end_date_or_today_date: 'after 3 months ago'
  access_filter_fields: [agencies.id]
  always_join: [clients]
  sql_always_where: clients.deleted is NULL or clients.deleted =0

  joins:
    - join: entry_screen
      sql_on: ${base.first_entry_screen_id} = ${entry_screen.id}   #need to figure out how to restrict data if private..
      type: inner
      sql_always_where: ref_agency = 0
      
    - join: entry_custom
      type: inner
      fields: [entry_custom_fields*]
      sql_on:  ${entry_custom.ref_program} = ${entry_screen.ref_program} AND  ${entry_custom.ref_status} = ${entry_screen.id} 
        
#     - join: inbound_recidivism
#       sql_on: ${entry_screen.id} = ${inbound_recidivism.screen_id}

    - join: last_screen
      sql_on: ${base.last_screening_to_analyze} = ${last_screen.id}
      type: left_outer
      
    - join: last_custom
      type: left_outer
      fields: [last_custom_fields*]
      sql_on: ${last_screen.id} = ${last_custom.ref_status}      
      
    - join: outbound_recidivism
      type: left_outer
      sql_on: ${last_screen.id} = ${outbound_recidivism.screen_id}
    
    - join: enrollments
      sql_on: ${base.ref_program} = ${enrollments.id}
      
    - join: members
      fields: []
      sql_on: ${enrollments.ref_user} = ${members.ref_user}    
      
    - join: programs
      fields: [ref_agency, name, project_type_code, funder, agency_project_name, id, list_of_program_names, added_date, description, count]
      sql_on: ${enrollments.ref_program} = ${programs.id}
      
    - join: agencies
      fields: [id, coc, name, county]
      sql_on: ${programs.ref_agency} = ${agencies.id}
      
    - join: counties
      fields: []
      sql_on: ${counties.id} = ${agencies.ref_county}
            
      
    - join: household_makeup
      sql_on: ${enrollments.ref_household} = ${household_makeup.id}

    - join: clients
#       type: full_outer revisit to try to get standalone assessments are part of the model
      sql_on: ${base.ref_client} = ${clients.id}

      
    - join: client_addresses
      sql_on: ${base.ref_client} = ${client_addresses.ref_client}  

    - join: static_demographics
      from: client_demographics
      fields: [id, gender, gender_text, ethnicity, ethnicity_text, name_middle, ref_client, race , race_text, veteran, veteran_text]
      sql_on: ${clients.id} = ${static_demographics.ref_client}
      
    - join: static_demographics_custom
      from: client_custom
      fields: [static_demographics_custom.client_custom_fields*]
      sql_on:  ${base.ref_client} = ${static_demographics_custom.ref_client}
      
    - join: client_service_programs
      fields: []
      type: left_outer
      sql_on: ${enrollments.id} = ${client_service_programs.ref_client_program}
      
    - join: client_services
      fields: []
      relationship: one_to_one
      sql_on: ${client_services.id} = ${client_service_programs.ref_client_service} and ( ${client_services.deleted} is null OR ${client_services.deleted} =0 ) 
      
      
    - join: service_items
      fields: []
      relationship: one_to_one
      sql_on: ${service_items.id} = ${client_services.ref_service_item}

    - join: client_service_notes
      fields: []
      sql_on: ${client_service_notes.ref_client_service} = ${client_services.id}
      
    - join: service_expenses
#       fields: []
      relationship: one_to_one
      sql_on: ${service_expenses.ref_client_service} = ${client_services.id}

    - join: services
      sql_on: ${service_items.ref_service} = ${services.id}
      
    - join: service_dates
      type: left_outer
      sql_on: ${service_dates.ref_client_service} = ${client_services.id}
      
    - join: client_assessments
      sql_on: ${clients.id} = ${client_assessments.ref_client}
      
    - join: client_assessment_scores
      fields: []
      sql_on: ${client_assessments.id} = ${client_assessment_scores.ref_assessment}
      
    - join: screens
      fields: []
      type: inner
      sql_on: ${screens.id} = ${client_assessments.ref_assessment}
      
    - join: client_assessment_custom
      sql_on: ${client_assessments.id} =${client_assessment_custom.id}

    - join: release_of_information
      sql_on: ${release_of_information.ref_client} =${clients.id}  and ( ${release_of_information.deleted} is null OR ${release_of_information.deleted} =0 ) 

    - join: roi_agencies
      from: agencies
      fields: []
      sql_on: ${release_of_information.ref_agency} =${roi_agencies.id}


- explore: population
  label: 'HMIS Population over Time'
  access_filter_fields: [agencies.id]
  joins:
   - join: entry_screen
     sql_on: ${population.first_entry_screen_id} = ${entry_screen.id}
     type: left_outer
 # #     - join: inbound_recidivism
# #       sql_on: ${entry_screen.id} = ${inbound_recidivism.screen_id}
# 
   - join: last_screen
     sql_on: ${population.last_screening_to_analyze} = ${last_screen.id}
     type: left_outer
#       
# #     - join: outbound_recidivism
# #       sql_on: ${last_screen.id} = ${outbound_recidivism.screen_id}
#     
   - join: enrollments
     sql_on: ${population.ref_program} = ${enrollments.id}
#       
   - join: programs
     fields: [ref_agency, name, project_type_code, funder, agency_project_name, id, list_of_program_names, added_date, description, count]
     sql_on: ${enrollments.ref_program} = ${programs.id}
#       
   - join: agencies
     fields: [id, coc,  name]
     sql_on: ${programs.ref_agency} = ${agencies.id}
# 
#     - join: household_makeup
#       sql_on: ${enrollments.ref_household} = ${household_makeup.id}
#       
   - join: clients
     sql_on: ${population.ref_client} = ${clients.id}
# 
   - join: static_demographics
     from: client_demographics
#      required_joins: clients
     fields: [id, gender, gender_text, ethnicity, ethnicity_text, ref_client, race, race_text, veteran, veteran_text]
     sql_on: ${clients.id} = ${static_demographics.ref_client}






- explore: clients
  persist_for: 60 minutes
  label: 'Services Model'
  access_filter_fields: [agencies.id]

  joins:

    - join: static_demographics
      from: client_demographics
#       required_joins: clients
      fields: [id, gender, gender_text, ethnicity, ethnicity_text, ref_client, race , race_text, veteran, veteran_text]
      sql_on: ${clients.id} = ${static_demographics.ref_client}
      
    - join: static_demographics_custom
      from: client_custom
      fields: [static_demographics_custom.client_custom_fields*]
      sql_on:  ${clients.id} = ${static_demographics_custom.ref_client}
      

    - join: client_services
      fields: []
      sql_on: ${client_services.ref_client} = ${clients.id}

    - join: service_items
      fields: []
      type: inner
#       required_joins: client_services
      sql_on: ${service_items.id} = ${client_services.ref_service_item}

    - join: client_service_notes
      fields: []
      sql_on: ${client_service_notes.ref_client_service} = ${client_services.id}
      
    - join: service_expenses
#       fields: []
      relationship: one_to_one
      sql_on: ${service_expenses.ref_client_service} = ${client_services.id}


    - join: services
      type: inner
      sql_on: ${service_items.ref_service} = ${services.id}


    - join: agencies
      fields: [id, coc, name]
      sql_on: ${client_services.ref_agency} = ${agencies.id}
      
    - join: client_addresses
      sql_on: ${clients.id} = ${client_addresses.ref_client}  
      
    - join: client_assessments
      sql_on: ${clients.id} = ${client_assessments.ref_client}
      
    - join: client_assessment_scores
      fields: []
      sql_on: ${client_assessments.id} = ${client_assessment_scores.ref_assessment}
      
    - join: screens
      fields: []
      type: inner
      sql_on: ${screens.id} = ${client_assessments.ref_assessment}
      
    - join: client_assessment_custom
      sql_on: ${client_assessments.id} =${client_assessment_custom.id}     
      
      
# - explore: client
#   from: clients
#   persist_for: 60 minutes
#   label: 'Client Assessments Model'
# 
#   joins:
# 
#     - join: static_demographics
#       from: client_demographics
# #       required_joins: clients
#       fields: [id, gender, gender_text, ethnicity, ethnicity_text, ref_client, race , race_text, veteran, veteran_text]
#       sql_on: ${client.id} = ${static_demographics.ref_client}
#       
#     - join: static_demographics_custom
#       from: client_custom
#       fields: [static_demographics_custom.client_custom_fields*]
#       sql_on:  ${client.id} = ${static_demographics_custom.ref_client}
#       
# 
#     - join: client_services
#       fields: []
#       sql_on: ${client_services.id} = ${client.id}
# 
#     - join: service_items
#       fields: []
#       type: inner
# #       required_joins: client_services
#       sql_on: ${service_items.id} = ${client_services.ref_service_item}
# 
#     - join: client_service_notes
#       fields: []
#       sql_on: ${client_service_notes.ref_client_service} = ${client_services.id}
#       
#     - join: service_expenses
# #       fields: []
#       relationship: one_to_one
#       sql_on: ${service_expenses.ref_client_service} = ${client_services.id}
# 
# 
#     - join: services
#       type: inner
#       sql_on: ${service_items.ref_service} = ${services.id}
# 
# 
#     - join: agencies
#       fields: [id, coc, name]
#       sql_on: ${client_services.ref_agency} = ${agencies.id}
#       
#     - join: client_addresses
#       sql_on: ${client.id} = ${client_addresses.ref_client}  
#       
#     - join: client_assessments
#       sql_on: ${client.id} = ${client_assessments.ref_client}
#       
#     - join: client_assessment_scores
#       fields: []
#       sql_on: ${client_assessments.id} = ${client_assessment_scores.ref_assessment}
#       
#     - join: screens
#       fields: []
#       type: inner
#       sql_on: ${screens.id} = ${client_assessments.ref_assessment}
#       
#     - join: client_assessment_custom
#       sql_on: ${client_assessments.id} =${client_assessment_custom.id}     
#             
      
- explore: agencies
#  fields: [id, coc, name, county]
  label: 'Project Descriptor Model'
  access_filter_fields: [agencies.id]

  joins:

    - join: counties
      fields: []
      sql_on: ${counties.id} = ${agencies.ref_county}  
      
    - join: programs
      from: programs
      sql_on: ${agencies.id} = ${programs.ref_agency}   
      
    - join: members
      sql_on: ${agencies.id} = ${members.ref_agency} 
    
    - join: users
      fields: []
      sql_on: ${users.id} = ${members.ref_user}     
      
    - join: agency_services
      from: agency_services
      sql_on: ${agencies.id} = ${agency_services.ref_agency}  
      
    - join: service_items
      fields: []
      sql_on: ${service_items.ref_service} = ${agency_services.id}      
      
    

