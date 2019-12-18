view: small_test_table {
  derived_table: {
    sql: SELECT 1 id, "string_1" some_string
      UNION ALL
      SELECT 2 id, "string_3" some_string
      UNION ALL
      SELECT 3 id, "string_3" some_string
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: some_string {
    type: string
    sql: ${TABLE}.some_string ;;
  }

  set: detail {
    fields: [id, some_string]
  }
}
