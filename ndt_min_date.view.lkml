view: ndt_min_date {
    derived_table: {
      sql: SELECT
        CONCAT(users.first_name,' ',users.last_name) AS `users.full_name`,
        DATE(min((DATE(orders.created_at )))) AS `orders.first_order`
      FROM demo_db.orders  AS orders
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      WHERE
        (users.state = 'California')
      GROUP BY 1
      ORDER BY DATE(min((DATE(orders.created_at )))) DESC
       ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: users_full_name {
      type: string
      sql: ${TABLE}.`users.full_name` ;;
    }

    dimension: orders_first_order {
      type: date
      sql: ${TABLE}.`orders.first_order` ;;
    }

    set: detail {
      fields: [users_full_name, orders_first_order]
    }
  }
