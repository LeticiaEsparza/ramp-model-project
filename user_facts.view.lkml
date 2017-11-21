view: user_facts {

    derived_table: {
      sql: SELECT
           order_items.user_id AS user_id, COUNT(orders.id) AS orders_count,
           MIN(NULLIF(order_items.created_at,0)) as first_order,
           MAX(NULLIF(order_items.created_at,0)) as latest_order
           FROM order_items
           GROUP BY user_id
      ;;
      sql_trigger_value: SELECT current_date;;
      indexes: ["user_id"]

    }

dimension_group: first_order {
  type: time
  timeframes: [date, week, month, year]
  sql: ${TABLE}.first_order ;;
}

dimension_group: latest_order {
  type: time
  timeframes: [date, week, month, year]
  sql: ${TABLE}.latest_order ;;
}

dimension: user_id {
  primary_key: yes
  #     hidden: true
  sql: ${TABLE}.user_id ;;
}

measure: orders_count {
  type: count_distinct
  sql: ${TABLE}.orders_count ;;
}

}
