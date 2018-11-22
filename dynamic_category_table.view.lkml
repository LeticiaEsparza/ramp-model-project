view: dynamic_category_table {
  derived_table: {
    sql: SELECT
        products.category  AS category,
        products.brand  AS brand,
        (COALESCE(SUM(order_items.sale_price), 0))-(COALESCE(COALESCE((0E0 +  ( SUM(DISTINCT (CAST(FLOOR(COALESCE(inventory_items.cost ,0)*((0E0 + 1000000)*1.0)) AS DECIMAL(65,0))) + (CAST(CONV(SUBSTR(MD5(inventory_items.id ),1,16),16,10) AS DECIMAL(65)) *18446744073709551616 + CAST(CONV(SUBSTR(MD5(inventory_items.id ), 17, 16), 16, 10) AS DECIMAL(65))) ) - SUM(DISTINCT (CAST(CONV(SUBSTR(MD5(inventory_items.id ),1,16),16,10) AS DECIMAL(65)) *18446744073709551616 + CAST(CONV(SUBSTR(MD5(inventory_items.id ), 17, 16), 16, 10) AS DECIMAL(65)))) ) ) / (0E0 + ((0E0 + 1000000))), 0), 0))  AS total_profit,
        COALESCE(SUM(order_items.sale_price), 0) AS total_revenue
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id

      WHERE {% condition category_filter %} products.category {% endcondition %}

      GROUP BY 1,2
      ORDER BY (COALESCE(SUM(order_items.sale_price), 0))-(COALESCE(COALESCE((0E0 +  ( SUM(DISTINCT (CAST(FLOOR(COALESCE(inventory_items.cost ,0)*((0E0 + 1000000)*1.0)) AS DECIMAL(65,0))) + (CAST(CONV(SUBSTR(MD5(inventory_items.id ),1,16),16,10) AS DECIMAL(65)) *18446744073709551616 + CAST(CONV(SUBSTR(MD5(inventory_items.id ), 17, 16), 16, 10) AS DECIMAL(65))) ) - SUM(DISTINCT (CAST(CONV(SUBSTR(MD5(inventory_items.id ),1,16),16,10) AS DECIMAL(65)) *18446744073709551616 + CAST(CONV(SUBSTR(MD5(inventory_items.id ), 17, 16), 16, 10) AS DECIMAL(65)))) ) ) / (0E0 + ((0E0 + 1000000))), 0), 0))  DESC
       ;;
  }

  filter: category_filter {
    type: string
    suggest_dimension: dynamic_category_table.category
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: total_profit {
    type: number
    sql: ${TABLE}.total_profit ;;
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  set: detail {
    fields: [category, brand, total_profit, total_revenue]
  }
}
