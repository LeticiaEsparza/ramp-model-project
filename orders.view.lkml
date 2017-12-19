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
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

measure: date_count {
  type: count
  filters:  {
    field: created_date
    value: "7 days"
  }
}

# coalesce(
#
# if(${orders.created_date}>=date(2017,01,01) AND ${orders.created_date}<date(2017,03,31),"winter",null),
#
# if(${orders.created_date}>=date(2017,03,31) AND ${orders.created_date}<date(2017,06,30),"spring",null),
#
# if(${orders.created_date}>= date(2017,06,30)AND ${orders.created_date}<date(2017,09,30),"summer",null),
#
# if(${orders.created_date}>= date(2017,09,30)AND ${orders.created_date}<=date(2017,12,31), "fall",null)
#
# )


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

}
