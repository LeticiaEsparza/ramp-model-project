view: counts_tester {
  derived_table: {
    sql: SELECT COUNT(*) FROM
      (SELECT COUNT(user_id)
      FROM orders
      WHERE user_id <> ''
      GROUP BY user_id
      HAVING COUNT(user_id) >= 2) as t
       ;;
    sql_trigger_value: SELECT current_date;;
    indexes: ["user_id"]
  }

  dimension: count {
    type: string
    sql: ${TABLE}.`COUNT(*)` ;;
  }

  set: detail {
    fields: [count]
  }
}
