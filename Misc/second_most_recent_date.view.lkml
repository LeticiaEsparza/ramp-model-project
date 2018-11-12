view: second_most_recent_date {
  derived_table: {
    sql: SELECT t1.id, t1.user_id,
        t1.created_at,
        COUNT(*) pos
      FROM orders t1
        LEFT JOIN orders t2
          ON t2.user_id = t1.user_id AND t2.created_at >= t1.created_at
      GROUP BY
        t1.id, t1.created_at
      HAVING
        pos = 2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

#   dimension: created_at {
#     type: string
#     sql: ${TABLE}.created_at ;;
#   }
#
  dimension_group: created_at {
    type: time
    timeframes: [raw, date, time, week, month]
    datatype: timestamp
    sql: ${TABLE}.created_at ;;
  }

  dimension: is_mau {
    type: yesno
    sql: ${user_facts.total_orders} >= 2 AND DATEDIFF(${user_facts.latest_order_date},${created_at_date}) <= 30 AND ${user_facts.repeat_customer} = "yes";;
  }


  dimension: pos {
    type: string
    sql: ${TABLE}.pos ;;
  }

  set: detail {
    fields: [id, user_id, pos]
  }
}
