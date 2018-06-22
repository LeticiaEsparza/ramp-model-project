view: ndt_dim_group_test {
  derived_table: {
    sql: SELECT
        DATE(orders.created_at ) AS `orders.created_date`,
        CAST(orders.created_at  AS CHAR) AS `orders.created_time`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id

      GROUP BY 1,2
      ORDER BY DATE(orders.created_at ) DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_created_date {
    type: date
    sql: ${TABLE}.`orders.created_date` ;;
  }

  dimension: orders_created_time {
    type: string
    sql: ${TABLE}.`orders.created_time` ;;
  }

  # dimension_group: dim_group {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  # }

  set: detail {
    fields: [orders_created_date, orders_created_time]
  }
}
