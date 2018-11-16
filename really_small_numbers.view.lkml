view: really_small_numbers {
  derived_table: {
    sql: SELECT 0.0000012345 as test
      UNION ALL
      SELECT 0.0000067898 as test
      UNION ALL
      SELECT 0.0000013579 as test
      UNION ALL
      SELECT 0.0000024681 as test
      UNION ALL
      SELECT 0.0000012345 as test
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: test_number {
    type: number
    sql: ${TABLE}.test ;;
  }

  dimension: smaller_number {
    type: number
    sql:  ${test_number}*0.0000000000012345;;
  }

  dimension: smaller_number_string {
    type: string
    sql: CAST(${smaller_number} AS string) ;;
  }

  set: detail {
    fields: [test_number]
  }
}
