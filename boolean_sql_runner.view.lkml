view: boolean_sql_runner {
  derived_table: {
    sql: SELECT true as test, "yes" as test_1
      UNION ALL
      SELECT true as test, "yes" as test_1
      UNION ALL
      SELECT false as test, "no" as test_1
      UNION ALL
      SELECT false as test, "no" as test_1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: test {
    type: number
    sql: ${TABLE}.test ;;
  }

  dimension: yesno_test {
    type: yesno
    sql: ${test} ;;
  }

  dimension: test_1 {
    type: string
    sql: ${TABLE}.test_1 ;;
  }

  set: detail {
    fields: [test, test_1]
  }
}
