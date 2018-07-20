view: test_format {
  derived_table: {
    sql: SELECT 0.26 as test_format_number
      UNION ALL
      SELECT 0.27 as test_format_number
      UNION ALL
      SELECT 0.28 as test_format_number
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: test_format_number {
    sql: ${TABLE}.test_format_number ;;
    value_format_name: percent_2
  }

  measure: percent_of_total_gross_margin {
    type: percent_of_total
    sql: ${test_format_number}*1.00 ;;
     value_format_name: percent_2
  }

  set: detail {
    fields: [test_format_number]
  }
}
