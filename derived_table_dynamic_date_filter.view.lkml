view: derived_table_dynamic_date_filter {
  derived_table: {
    sql: SELECT
        DATE(orders.created_at ) AS created_date,
        CAST(orders.created_at  AS CHAR) AS created_time,
        orders.id  AS orders_id,
        CONCAT(users.first_name,' ',users.last_name) AS full_name,
        COALESCE(SUM(order_items.sale_price ), 0) AS total_sale_price
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      WHERE {% condition date_filter %} orders.created_at {% endcondition %}
      GROUP BY 1,2,3,4
      ORDER BY DATE(orders.created_at ) DESC
       ;;

    sql_trigger_value: SELECT current_date;;
    indexes: ["orders_id"]
  }

  # HAVING {% condition threshold %} COALESCE(SUM(order_items.sale_price ), 0) {% endcondition %}

  filter: date_filter {
    type: date
  }

  filter: threshold {
    type: number
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }

  dimension_group: created_time {
    type: time
    timeframes: [raw, date, time, week, month, year]
    sql: ${TABLE}.created_time ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: total_sale_price {
    type: number
    sql: ${TABLE}.total_sale_price ;;
  }

  set: detail {
    fields: [created_date, created_time_time, orders_id, full_name, total_sale_price]
  }
}
