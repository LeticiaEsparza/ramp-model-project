view: user_facts_test {

  derived_table: {
    sql: SELECT
           orders.user_id AS user_id,
           COUNT(DISTINCT orders.id) AS total_orders,
           MIN(NULLIF(orders.created_at,0)) as first_order,
           MAX(NULLIF(orders.created_at,0)) as latest_order,
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
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: total_orders {
    type: string
    sql: ${TABLE}.total_orders ;;
  }

  dimension: first_order {
    type: string
    sql: ${TABLE}.first_order ;;
  }

  dimension: latest_order {
    type: string
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

  set: detail {
    fields: [
      user_id,
      total_orders,
      first_order,
      latest_order,
      repeat_customer,
      days_since_first_purchase
    ]
  }

}
