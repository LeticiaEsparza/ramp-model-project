view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }


# dimension: created_string {
#   type: string
#   sql: ${created_quarter} ;;
# }
#
# dimension: quarter_test {
#   type: string
#   case: {
#     when: {
#       sql: ${created_string} LIKE '%-01%'  ;;
#       label: "Q1"
#     }
#     when: {
#       sql: ${created_string} LIKE '-%04%' ;;
#       label: "Q2"
#     }
#     when: {
#       sql: ${created_string} LIKE '%-07%' ;;
#       label: "Q3"
#     }
#     # Possibly more when statements
#     else: "Q4"
#   }
# }

measure: date_count {
  type: count
  filters:  {
    field: created_date
    value: "7 days"
  }
}

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

 # measure: first_order {
  #  type: min
  #  sql: ${created_date};;
   # drill_fields: [users.id, users.full_name, products.category]
  #}

  measure: first_order {
    type: date
    sql: min(${created_date});;
    drill_fields: [users.id, users.full_name, products.category]

  }

measure: last_order {
  type: date
  sql: max(${created_date}) ;;
  drill_fields: [users.id, users.full_name, products.category]
}

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }

  #parameter practice

  parameter: date_granularity {
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }

  dimension: date {
    label_from_parameter: date_granularity
    sql:
       CASE
         WHEN {% parameter date_granularity %} = 'Day' THEN
           ${created_date}::VARCHAR
         WHEN {% parameter date_granularity %} = 'Month' THEN
           ${created_month}::VARCHAR
         WHEN {% parameter date_granularity %} = 'Quarter' THEN
           ${created_quarter}::VARCHAR
         WHEN {% parameter date_granularity %} = 'Year' THEN
           ${created_year}::VARCHAR
         ELSE
           NULL
       END ;;
  }

filter: year_filter {
  type: number
}

dimension: status_satisfies_filter {
  type: yesno
  sql: {% condition ${year_filter} %} ${created_year} {% endcondition %}  ;;
}

measure: count_year_filter {
  type: count
  filters: {
    field: created_year
    value: "2017"
  }
}

measure: percentage_orders_2017_over_total {
  type: number
  sql: ${count_year_filter}/${count} ;;
}




}
