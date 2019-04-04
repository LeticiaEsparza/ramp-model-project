view: srinija_test {
  derived_table: {
    sql: SELECT num, status, count(*) count FROM
      (
      SELECT 1 num, "complete" status
      UNION ALL
      SELECT 2 num, "complete" status
      UNION ALL
      SELECT 3 num, "in progress" status
      UNION ALL
      SELECT 5 num, "in progress" status
      UNION ALL
      SELECT 6 num, "not started" status
      ) AS first_table
       ;;
  }

  dimension: num {
    type: number
    sql: ${TABLE}.num ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
  }

  set: detail {
    fields: [num, status, count]
  }
}
