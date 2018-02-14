view: running_total_test {
    derived_table: {
      sql: SELECT order_items.id,
        CASE
      WHEN (order_items.sale_price - inventory_items.cost)  < 0.0 THEN 0
      WHEN (order_items.sale_price - inventory_items.cost)  >= 0.0 AND (order_items.sale_price - inventory_items.cost)  < 10.0 THEN 10
      WHEN (order_items.sale_price - inventory_items.cost)  >= 10.0 AND (order_items.sale_price - inventory_items.cost)  < 20.0 THEN 20
      WHEN (order_items.sale_price - inventory_items.cost)  >= 20.0 AND (order_items.sale_price - inventory_items.cost)  < 30.0 THEN 30
      WHEN (order_items.sale_price - inventory_items.cost)  >= 30.0 AND (order_items.sale_price - inventory_items.cost)  < 40.0 THEN 40
      WHEN (order_items.sale_price - inventory_items.cost)  >= 40.0 AND (order_items.sale_price - inventory_items.cost)  < 50.0 THEN 50
      WHEN (order_items.sale_price - inventory_items.cost)  >= 50.0 AND (order_items.sale_price - inventory_items.cost)  < 60.0 THEN 60
      WHEN (order_items.sale_price - inventory_items.cost)  >= 60.0 AND (order_items.sale_price - inventory_items.cost)  < 70.0 THEN 70
      WHEN (order_items.sale_price - inventory_items.cost)  >= 70.0 AND (order_items.sale_price - inventory_items.cost)  < 80.0 THEN 80
      WHEN (order_items.sale_price - inventory_items.cost)  >= 80.0 AND (order_items.sale_price - inventory_items.cost)  < 100.0 THEN 90
      WHEN (order_items.sale_price - inventory_items.cost)  >= 100.0 THEN 100
      ELSE 'TXX Undefined'
      END AS `order_items.case_profit`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
       ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: id {
      type: string
      sql: ${TABLE}.id ;;
    }

    measure: order_items_case_profit {
      type: number
      sql: ${TABLE}.`order_items.case_profit` ;;
    }

    measure: running_total {
      type: running_total
      sql: ${order_items_case_profit} ;;
    }

    set: detail {
      fields: [id, order_items_case_profit]
    }

}
