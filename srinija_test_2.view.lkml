view: srinija_test_2 {
  derived_table: {
    sql: SELECT num, status, count
         FROM ${srinija_test.SQL_TABLE_NAME}
         {% if srinija_test_2.count > 0 %}
          WHERE status = "complete"
         {% else %}
          WHERE 1=1
         {% endif %}
        GROUP BY status
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
