view: the_test {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'orders.created_week'


              SELECT zz1.* FROM (
              SELECT
                 @min_rank := IF(!_ct2, _rank, @min_rank) as m_rank
                 , zz.*
              FROM (
              SELECT
                 (@curType1 IS NOT NULL AND @curType1 = COALESCE(`products.category`,'')) as _ct2
                , @curType1 := COALESCE(`products.category`,'') as _ct1
                , xx.*
              FROM (
                  SELECT * FROM (
                     SELECT
                           (
                              CASE COALESCE(`orders.created_week`,'')
                              WHEN @curType
                              THEN @curRow := @curRow + 1
                              ELSE @curRow := 1 AND @curType := COALESCE(`orders.created_week`,'') END
                            ) AS _rank,
                            ww.*
                     FROM (
      SELECT
        products.category  AS `products.category`,
        DATE_FORMAT(TIMESTAMP(DATE(DATE_ADD(orders.created_at ,INTERVAL (0 - MOD((DAYOFWEEK(orders.created_at ) - 1) - 1 + 7, 7)) day))), '%Y-%m-%d') AS `orders.created_week`,
        (COALESCE(SUM(order_items.sale_price), 0))-(COALESCE(COALESCE((0E0 +  ( SUM(DISTINCT (CAST(FLOOR(COALESCE(inventory_items.cost ,0)*(1000000*1.0)) AS DECIMAL(65,0))) + (CAST(CONV(SUBSTR(MD5(inventory_items.id ),1,16),16,10) AS DECIMAL(65)) *18446744073709551616 + CAST(CONV(SUBSTR(MD5(inventory_items.id ), 17, 16), 16, 10) AS DECIMAL(65))) ) - SUM(DISTINCT (CAST(CONV(SUBSTR(MD5(inventory_items.id ),1,16),16,10) AS DECIMAL(65)) *18446744073709551616 + CAST(CONV(SUBSTR(MD5(inventory_items.id ), 17, 16), 16, 10) AS DECIMAL(65)))) ) ) / (0E0 + (1000000*1.0)), 0), 0))  AS `order_items.total_profit`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id

      WHERE
        (((orders.created_at ) >= (TIMESTAMP('2015-08-01')) AND (orders.created_at ) < (TIMESTAMP('2015-08-31'))))
      GROUP BY 1,2        ) as ww
              , (SELECT @min_rank := 1000000, @curType1 := NULL, @curRow :=0, @curType := '') r
      ORDER BY `orders.created_week`, `order_items.total_profit` DESC
              ) xx1
              ORDER BY `products.category`, _rank
              ) as xx
              ORDER BY `products.category`, _rank, _ct2
              ) as zz
              ORDER BY `products.category`, _rank, _ct2
              ) as zz1
      WHERE m_rank <= 500 LIMIT 30000
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: m_rank {
    type: string
    sql: ${TABLE}.m_rank ;;
  }

  dimension: _ct2 {
    type: number
    sql: ${TABLE}._ct2 ;;
  }

  dimension: _ct1 {
    type: string
    sql: ${TABLE}._ct1 ;;
  }

  dimension: _rank {
    type: number
    sql: ${TABLE}._rank ;;
  }

  dimension: products_category {
    type: string
    sql: ${TABLE}.`products.category` ;;
  }

  dimension: orders_created_week {
    type: string
    sql: ${TABLE}.`orders.created_week` ;;
  }

  dimension: order_items_total_profit {
    type: number
    sql: ${TABLE}.`order_items.total_profit` ;;
  }

  set: detail {
    fields: [
      m_rank,
      _ct2,
      _ct1,
      _rank,
      products_category,
      orders_created_week,
      order_items_total_profit
    ]
  }
}
