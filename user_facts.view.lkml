view: user_facts {

  derived_table: {
    sql: SELECT
           orders.user_id AS user_id,
           COUNT(DISTINCT orders.id) AS total_orders,
           MIN(NULLIF(orders.created_at,0)) as first_order,
           MAX(NULLIF(orders.created_at,0)) as latest_order,
           orders.created_at,
           CASE WHEN COUNT(orders.created_at)>1 THEN 'yes' ELSE 'no' END AS repeat_customer,
           DATEDIFF(CURDATE(), MIN(NULLIF(orders.created_at,0))) AS days_since_first_purchase
           FROM order_items JOIN orders ON order_items.order_id=orders.id
           GROUP BY orders.user_id
           ORDER BY COUNT(DISTINCT orders.id) desc




 ;;

    sql_trigger_value: SELECT current_date;;
    indexes: ["user_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }


#   dimension: test {
#     type: number
#     sql: ${total_orders}-${user_id} ;;
#   }

  dimension: first_order {
    type: string
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: latest_order {
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
    sql: ${TABLE}.latest_order ;;

  }

  dimension: repeat_customer {
    type: string
    sql: ${TABLE}.repeat_customer ;;
  }

#   dimension: avg_orders_per_month {
#     type: string
#     sql: ${TABLE}.avg_orders_per_month ;;
#   }

  dimension: days_since_first_purchase {
    type: string
    sql: ${TABLE}.days_since_first_purchase ;;
  }

dimension_group: created_at {
  type: time
  timeframes: [raw, date, time, week, month]
  datatype: timestamp
  sql: ${TABLE}.created_at ;;
}

#   dimension: is_mau {
#     type: yesno
#     sql: ${total_orders} >= 2 AND DATEDIFF(${latest_order_date},${second_most_recent_date.created_at_date}) <= 30 AND ${repeat_customer} = "yes";;
#   }


  set: detail {
    fields: [
      user_id,
      total_orders,
      first_order,
#       latest_order,
      repeat_customer,
      days_since_first_purchase
    ]
  }

}
