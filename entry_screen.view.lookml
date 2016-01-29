- view: entry_screen
  sql_table_name: |
    client_program_demographics
  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: added
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension: age
    label: 'Age at Entry'
    type: number
    sql: YEAR(${enrollments.start_date}) - YEAR(${clients.birth_date}) - (DATE_FORMAT(${enrollments.start_date}, '%m%d') < DATE_FORMAT(${clients.birth_date}, '%m%d'))

  - dimension: age_tier
    type: tier
    style: integer
    tiers: [0,18,25,35,45,55,65]
    sql: ${age}


  - measure: total_adults
    type: count_distinct   # can be average, sum, min, max, count, count_distinct, or number
    sql: ${ref_client}
    filters:
      age: '>=18'

  - measure: total_children
    type: count_distinct   # can be average, sum, min, max, count, count_distinct, or number
    sql: ${ref_client}
    filters:
      age: '<18'

  - dimension: benefits_snap
    label: 'Non cash: Has SNAP'
    type: yesno
    sql: ${TABLE}.benefit_snap
    
  - dimension: benefits_medicaid
    label: 'Health Insurance: Has Medicaid'
    type: yesno
    sql: ${TABLE}.benefits_medicaid

  - dimension: benefits_medicare
    label: 'Health Insurance: Has Medicare'
    type: yesno
    sql: ${TABLE}.benefits_medicare

  - dimension: benefits_no_insurance
    label: 'Health Insurance: No Health Insurance'
    type: yesno
    sql: ${TABLE}.benefits_no_insurance

  - dimension: benefits_noncash
    label: 'Non cash: Any Non Cash Benefit'
#     sql: ${TABLE}.benefits_noncash
    sql: fn_getPicklistValueName('benefits_noncash', ${TABLE}.benefits_noncash)

  - dimension: benefits_other
    hidden: true
    type: int
    sql: ${TABLE}.benefits_other

  - dimension: benefits_other_source
    hidden: true
    sql: ${TABLE}.benefits_other_source

  - dimension: benefits_private_insurance
    label: 'Health Insurance Has Private Insurance'
    type: yesno
    sql: ${TABLE}.benefits_private_insurance

  - dimension: benefits_schip
    label: 'Health Insurance: Has SCHIP'
    type: yesno
    sql: ${TABLE}.benefits_schip

  - dimension: benefits_section8
    label: 'Non cash: Has Section 8'
    type: yesno
    sql: ${TABLE}.benefits_section8

  - dimension: benefits_tanf_childcare
    label: 'Non cash: Has TANF Childcare'
    type: yesno
    sql: ${TABLE}.benefits_tanf_childcare

  - dimension: benefits_tanf_other
    label: 'Non cash: Has TANF Other'
    type: yesno
    sql: ${TABLE}.benefits_tanf_other

  - dimension: benefits_tanf_transportation
    label: 'Non cash: Has TANF Transportaion'
    type: yesno
    sql: ${TABLE}.benefits_tanf_transportation

  - dimension: benefits_temp_rent
    label: 'Non cash: Has Temporary Rental Assistance'
    type: yesno
    sql: ${TABLE}.benefits_temp_rent

  - dimension: benefits_va_medical
    label: 'Health Insurance: Has VA Medical Insurance'
    type: yesno
    sql: ${TABLE}.benefits_va_medical

  - dimension: benefits_wic
    label: 'Non cash: HAS WIC'
    type: yesno
    sql: ${TABLE}.benefits_wic

  - dimension: chronic_1
    hidden: true
    type: int
    sql: ${TABLE}.chronic_1

  - dimension: chronic_2
    hidden: true   
    type: int
    sql: ${TABLE}.chronic_2

  - dimension: chronic_3
    label: 'Length of time on street, in an emergency shelter, or safe haven'
    sql: fn_getPicklistValueName('chronic_3',${TABLE}.chronic_3)


  - dimension: chronic_4
    hidden: true
    type: int
    sql: ${TABLE}.chronic_4

  - dimension: chronic_5
    hidden: true
    type: int
    sql: ${TABLE}.chronic_5

  - dimension: chronic_homeless
    hidden: true
    type: int
    sql: ${TABLE}.chronic_homeless

  - dimension: chronic_homeless_calculation
    bypass_suggest_restrictions: true  
    type: yesno
    sql: |
      ${enrollments.head_of_household} = 1
      AND ${TABLE}.disabled = 1 AND  
      ( ${TABLE}.chronic_1 = 1 OR  ${TABLE}.chronic_2 = 4)



 
  - dimension: client_location
    label: 'CoC Code of Client on Enrollment'
    hidden: true
    sql: ${TABLE}.client_location

  - dimension: disabled
    hidden: true
    type: int
    sql: ${TABLE}.disabled

  - dimension: any_disability
    label: 'Disability: Any'
    sql_case:
            No Disability: ${disabled} = 0
            Disability: ${disabled} = 1
            else: Unknown


  - dimension: health_chronic
    label: 'Disability: Chronic Health'
    sql: ${TABLE}.health_chronic
    sql: fn_getPicklistValueName('health_chronic',${TABLE}.health_chronic)
  
  - dimension: health_chronic_services
    label: 'Disability: Chronic Health Services'
    sql: fn_getPicklistValueName('health_chronic_services',${TABLE}.health_chronic_services)

  #- dimension: health_chronic_documented
  #  type: int
  #  sql: ${TABLE}.health_chronic_documented

  #- dimension: health_chronic_longterm
  #  type: int
  #  sql: ${TABLE}.health_chronic_longterm

  #- dimension: health_chronic_services
  #  type: int
  #  sql: ${TABLE}.health_chronic_services

  - dimension: health_dev_disability
    label: 'Disability: Developmental'
    type: yesno
    sql: ${TABLE}.health_dev_disability

  - dimension: health_dev_disability_services
    label: 'Disability: Developmental Disability Services'
    type: int
    sql: ${TABLE}.health_dev_disability_services



  #- dimension: health_dev_disability_documented
  #  type: int
  #  sql: ${TABLE}.health_dev_disability_documented

  #- dimension: health_dev_disability_independence
  #  type: int
  #  sql: ${TABLE}.health_dev_disability_independence

  #- dimension: health_dev_disability_services
  #  type: int
  #  sql: ${TABLE}.health_dev_disability_services

  - dimension: health_dv
    label: 'Domestic Violence'
    type: yesno
    sql: ${TABLE}.health_dv

  - dimension: health_dv_occurred
    sql: fn_getPicklistValueName('health_dv_occurred',${TABLE}.health_dv_occurred)

  - dimension: Employed
    sql: fn_getPicklistValueName('employment_is',${TABLE}.employment_is)

  #- dimension: health_general
  #  type: int
  #  sql: ${TABLE}.health_general

  - dimension: health_hiv
    label: 'Disability: HIV/AIDS'
    type: yesno
    sql: ${TABLE}.health_hiv
    
  - dimension: health_hiv_services
    label: 'Disability: HIV/AIDS Services'
    type: int
    sql: ${TABLE}.health_hiv_services    


#  - dimension: health_hiv_documented
#    type: int
#    sql: ${TABLE}.health_hiv_documented

#  - dimension: health_hiv_independence
#    type: int
#    sql: ${TABLE}.health_hiv_independence

#  - dimension: health_hiv_services
#    type: int
#    sql: ${TABLE}.health_hiv_services

  - dimension: health_ins_cobra
    label: 'Health Insurance: Has COBRA'
    type: yesno
    sql: ${TABLE}.health_ins_cobra

  - dimension: health_ins_emp
    label: 'Health Insurance: Has Employer Provided'
    type: yesno
    sql: ${TABLE}.health_ins_emp

  - dimension: health_ins_ppay
    label: 'Health Insurance: Has Private Pay'
    type: yesno
    sql: ${TABLE}.health_ins_ppay

  - dimension: health_ins_state
    label: 'Health Insurance: Has State Insurance for Adults'
    type: yesno
    sql: ${TABLE}.health_ins_state

  - dimension: health_insurance
    label: 'Health Insurance: Covered by Health Insurance'
    type: yesno
    sql: ${TABLE}.health_insurance

  - dimension: health_mental
    label: 'Disability: Mental Health'
    type: yesno
    sql: ${TABLE}.health_mental

  - dimension: health_mental_services
    label: 'Disability: Mental Health Services'
    type: int
    sql: ${TABLE}.health_mental_services


 
#   - dimension: health_mental_confirmed
#     type: int
#     sql: ${TABLE}.health_mental_confirmed
# 
#   - dimension: health_mental_documented
#     type: int
#     sql: ${TABLE}.health_mental_documented
# 
#   - dimension: health_mental_longterm
#     type: int
#     sql: ${TABLE}.health_mental_longterm
# 
#   - dimension: health_mental_services
#     type: int
#     sql: ${TABLE}.health_mental_services
# 
#   - dimension: health_mental_smi
#     type: int
#     sql: ${TABLE}.health_mental_smi

  - dimension: health_phys_disability
    label: 'Disability: Physical'
    type: yesno
    sql: ${TABLE}.health_phys_disability
    
  - dimension: health_phys_disability_services
    label: 'Disability: Physical Services'
    type: int
    sql: ${TABLE}.health_phys_disability_services    
    
# 
#   - dimension: health_phys_disability_documented
#     type: int
#     sql: ${TABLE}.health_phys_disability_documented
# 
#   - dimension: health_phys_disability_longterm
#     type: int
#     sql: ${TABLE}.health_phys_disability_longterm
# 
#   - dimension: health_phys_disability_services
#     type: int
#     sql: ${TABLE}.health_phys_disability_services
# 
#   - dimension: health_pregnancy
#     type: int
#     sql: ${TABLE}.health_pregnancy
# 
#   - dimension_group: health_pregnancy
#     type: time
#     timeframes: [date, week, month]
#     convert_tz: false
#     sql: ${TABLE}.health_pregnancy_date

  - dimension: health_substance_abuse
    label: 'Disability: Substance Abuse'
    sql: fn_getPicklistValueName('health_substance_abuse',${TABLE}.health_substance_abuse)
    
  - dimension: health_substance_abuse_services
    label: 'Disability: Substance Abuse Services'
    type: int
    sql: ${TABLE}.health_substance_abuse_services    

#   - dimension: health_substance_abuse_confirmed
#     type: int
#     sql: ${TABLE}.health_substance_abuse_confirmed
# 
#   - dimension: health_substance_abuse_documented
#     type: int
#     sql: ${TABLE}.health_substance_abuse_documented
# 
#   - dimension: health_substance_abuse_longterm
#     type: int
#     sql: ${TABLE}.health_substance_abuse_longterm
# 
#   - dimension: health_substance_abuse_services
#     type: int
#     sql: ${TABLE}.health_substance_abuse_services

  #- dimension: housing_ass_exit
   # type: int
  #  sql: ${TABLE}.housing_ass_exit

  #- dimension: housing_ass_exit_1
  #  type: int
  #  sql: ${TABLE}.housing_ass_exit_1

  #- dimension: housing_ass_exit_2
  #  type: int
  #  sql: ${TABLE}.housing_ass_exit_2

  - dimension: housing_status
    hidden: true
    type: int
    sql: ${TABLE}.housing_status

  - dimension: housing_status_text
    label: 'Housing Status @ Entry'
    sql: fn_getPicklistValueName('housing_status',${housing_status})

  - dimension: entered_stably_housed
    type: yesno
    sql: ${housing_status_text} = 'Stably housed'

  - measure: count_stably_housed
    type: count_distinct
    sql: ${ref_client}
    filters:
      housing_status_text: 'Stably housed'
      
  - measure: count_asked_about_housing
    hidden: true
    type: count_distinct
    sql: ${ref_client}
    filters:
      housing_status_text: -NULL
      
  - measure: percent_stably_housed
    type: number
    format: '%0.1f%'
    sql: 100.0 * ${count_stably_housed} / NULLIF(${count_asked_about_housing},0)

  - dimension: income_cash
    hidden: true
    type: number
    sql: ${TABLE}.income_cash

  - dimension: income_cash_is
    hidden: true
    type: int
    sql: ${TABLE}.income_cash_is

  - dimension: any_income
    label: 'Income: Income from any Source'
    sql_case:
            No Income: ${income_cash_is} = 0
            Income: ${income_cash_is} = 1
            else: Unknown
            
  - dimension: income_childsupport
    label: 'Income: Child Support'
    type: int
    sql: ${TABLE}.income_childsupport

  - dimension: income_childsupport_is
    label: 'Income: Has Childsupport'
    type: yesno
    sql: ${TABLE}.income_childsupport_is

  - dimension: income_earned
    label: 'Income: Earned Income Amount'
    type: number
    hidden: true
    sql: ${TABLE}.income_earned
    
  - dimension: income_earned_tier
    label: 'Income: Earned Tiers'
    type: tier
    style: integer
    tiers: [0,100,500,1000,5000]
    sql: ${income_earned}
    
  - measure: average_income_earned
    label: 'Income: Average Earned'
    type: average   # can be average, sum, min, max, count, count_distinct, or number
    format: '$%0.0f'
    drill_fields: [income_earned_tier, count]
    sql: ${income_earned}
    drill_fields: detail*
    
  - measure: average_cash_income
    type: average   # can be average, sum, min, max, count, count_distinct, or number
    format: '$%0.0f'
    sql: ${income_individual}      

 
  - measure: total_income_earned
    label: 'Income: Total Earned'
    type: sum   # can be average, sum, min, max, count, count_distinct, or number
    format: '$%0.0f'
    sql: ${income_earned}    
    drill_fields: detail*

  - dimension: income_earned_is
    label: 'Income: Has Earned Income'
    type: yesno
    hidden: true
    sql: ${TABLE}.income_earned_is

  - measure: count_with_income
    type: count_distinct
    sql: ${ref_client}
    filters:
      any_income: 'Income'
      
  - measure: count_asked_about_income
    hidden: true
    type: count_distinct
    sql: ${ref_client}
    filters:
      any_income: No Income,Income
      
  - measure: percent_with_income
    type: number
    format: '%0.1f%'
    sql: 100.0 * ${count_with_income} / NULLIF(${count_asked_about_income},0)

  - dimension: income_ga
    type: number
    hidden: true
    label: 'Income: General Assistance Amount'
    sql: ${TABLE}.income_ga

  - dimension: income_ga_is
    label: 'Income: Has General Assistance'
    type: yesno
    sql: ${TABLE}.income_ga_is

  - dimension: income_individual  # TOtal cash income for individual
    label: 'Total Cash Income'
    type: number
    sql: ${TABLE}.income_individual
    
  - measure: total_cash_income
    type: sum   # can be average, sum, min, max, count, count_distinct, or number
    format: '$%0.0f'
    sql: ${income_individual}  

#   - dimension: income_other
#     hidden: true
#     type: number
#     sql: ${TABLE}.income_other
# 
#   - dimension: income_other_is
#     type: int
#      sql: ${TABLE}.income_other_is
# 
#   - dimension: income_other_source
#     sql: ${TABLE}.income_other_source

  - dimension: income_private_disability
    label: 'Income: Private Disability Insurance'
    hidden: true
    type: number
    sql: ${TABLE}.income_private_disability

  - dimension: income_private_disability_is
    label: 'Income: Has Private Disability Insurance'
    type: yesno
    sql: ${TABLE}.income_private_disability_is

  - dimension: income_private_pension
    hidden: true
    type: number
    sql: ${TABLE}.income_private_pension

  - dimension: income_private_pension_is
    label: 'Income: Has Private Pension'
    type: yesno
    sql: ${TABLE}.income_private_pension_is

  - dimension: income_spousal_support
    hidden: true
    type: number
    sql: ${TABLE}.income_spousal_support

  - dimension: income_spousal_support_is
    label: 'Income: Has Spousal Support'
    type: yesno
    sql: ${TABLE}.income_spousal_support_is

  - dimension: income_ss_retirement
    hidden: true
    type: number
    sql: ${TABLE}.income_ss_retirement

  - dimension: income_ss_retirement_is
    label: 'Income: Has Soc Sec Retirement'
    type: yesno
    sql: ${TABLE}.income_ss_retirement_is

  - dimension: income_ssdi
    hidden: true
    type: number
    sql: ${TABLE}.income_ssdi

  - dimension: income_ssdi_is
    label: 'Income: Has SSDI'
    sql_case:
            No SSDI: ${TABLE}.income_ssdi_is = 0
            SSDI: ${TABLE}.income_ssdi_is = 1
            else: Unknown 

  - dimension: income_ssi
    hidden: true
    type: number
    sql: ${TABLE}.income_ssi

  - dimension: income_ssi_is
    label: 'Income: Has SSI'
    type: yesno
    sql: ${TABLE}.income_ssi_is

  - dimension: income_tanf
    hidden: true
    type: number
    sql: ${TABLE}.income_tanf

  - dimension: income_tanf_is
    label: 'Income: Has TANF'
    type: yesno
    sql: ${TABLE}.income_tanf_is

  - dimension: income_unemployment
    hidden: true
    label: 'Income: Unemployment Amount'
    type: number
    sql: ${TABLE}.income_unemployment
    
  - measure: total_unemployment_income
    hidden: true
    label: 'Income: Total Unemployment Income'
    type: sum   # can be average, sum, min, max, count, count_distinct, or number
    format: '$%0.0f'
    sql: ${income_unemployment}      

  - dimension: income_unemployment_is
    label: 'Income: Has Unemployement Income'
    type: yesno
    sql: ${TABLE}.income_unemployment_is

  - dimension: income_vet_disability
    hidden: true
    type: number
    sql: ${TABLE}.income_vet_disability

  - dimension: income_vet_disability_is
    label: 'Income: Has Veteran Disability'
    type: yesno
    sql: ${TABLE}.income_vet_disability_is

  - dimension: income_vet_pension
    hidden: true
    type: number
    sql: ${TABLE}.income_vet_pension

  - dimension: income_vet_pension_is
    label: 'Income: Has Veteran Pension'    
    type: yesno
    sql: ${TABLE}.income_vet_pension_is

  - dimension: income_workers_comp
    hidden: true
    type: number
    sql: ${TABLE}.income_workers_comp

  - measure: total_workers_comp_income
    hidden: true
    label: 'Income: Total Unemployment Income'
    type: sum   # can be average, sum, min, max, count, count_distinct, or number
    format: '$%0.0f'
    sql: ${income_workers_comp}    

  - dimension: income_workers_comp_is
    label: 'Income: Has Workers Comp'
    type: yesno
    sql: ${TABLE}.income_workers_comp_is

  - dimension_group: last_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: marital_status
    hidden: true
    type: int
    sql: ${TABLE}.marital_status

  - dimension_group: move_in
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.move_in_date

  - dimension: permanent_housing_is
    type: int
    sql: ${TABLE}.permanent_housing_is


  - dimension: prior_city
    sql: ${TABLE}.prior_city

  - dimension: prior_duration
    type: int
    sql: ${TABLE}.prior_duration

  - dimension: prior_residence
    hidden: true
    type: int
    sql: ${TABLE}.prior_residence

  - dimension: prior_residence_text
    label: 'Residence Prior to Project Entry'
    sql: fn_getPicklistValueName('prior_residence',${prior_residence})    


  - dimension: prior_residence_other
    hidden: true
    sql: ${TABLE}.prior_residence_other

  - dimension: prior_state
    sql: ${TABLE}.prior_state

  - dimension: prior_street_address
    hidden: true
    sql: ${TABLE}.prior_street_address

  - dimension_group: program
    label: 'Information Date'
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.program_date

#   - dimension_group: program_entry
#     type: time
#     timeframes: [date, week, month]
#     convert_tz: false
#     sql: ${TABLE}.program_entry
# 
#   - dimension_group: program_exit
#     type: time
#     timeframes: [date, week, month]
#     convert_tz: false
#     sql: ${TABLE}.program_exit

  - dimension: ref_agency
    hidden: true
    type: int
    sql: ${TABLE}.ref_agency

  - dimension: ref_client
    hidden: true
    type: int
    sql: ${TABLE}.ref_client

  - dimension: ref_program
    hidden: true
    type: int
    sql: ${TABLE}.ref_program

  - dimension: ref_user
    hidden: true
    type: int
    sql: ${TABLE}.ref_user

  - dimension: ref_user_updated
    hidden: true    
    type: int
    sql: ${TABLE}.ref_user_updated

  - dimension: screen_type
    hidden: true
    type: int
    sql: ${TABLE}.screen_type

  - dimension: screen_type_text
    hidden: true
    sql: |
      CASE
      WHEN ${screen_type} = 2 THEN '1 - Enrollment'
      WHEN ${screen_type} = 3 THEN '2 - Update'
      WHEN ${screen_type} = 4 THEN '4 - Exit'
      WHEN ${screen_type} = 5 THEN '3 - Annual Assessment'
      END
    

  - dimension: zipcode
    type: zipcode
    sql: ${TABLE}.zipcode

  - dimension: zipcode_quality
    type: int
    sql: ${TABLE}.zipcode_quality

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
      - clients.id
      - client_programs.id
      - clients.full_name
      - programs.name
      - client_programs.start_date
      - entry_screen.housing_status_text
      - client_programs.end_date
      - client_programs.still_in_program


