view: table_calc_test_table {
  derived_table: {
    sql: SELECT CAST("2017-07-05" AS DATE) as created, 1 as accuracy_matcher, 1 as control
      UNION
      SELECT CAST("2017-07-04" AS DATE) as created, 1 as accuracy_matcher, 2 as control
      UNION
      SELECT CAST("2017-07-03" AS DATE) as created, 0.95 as accuracy_matcher, 3 as control
      UNION
      SELECT CAST("2017-07-02" AS DATE) as created, 0.90 as accuracy_matcher, 4 as control
      UNION
      SELECT CAST("2017-07-01" AS DATE) as created, 0.85 as accuracy_matcher, 5 as control
      UNION
      SELECT CAST("2017-06-30" AS DATE) as created, 0.80 as accuracy_matcher, 6 as control
      UNION
      SELECT CAST("2017-06-29" AS DATE) as created, 0.75 as accuracy_matcher, 7 as control
      UNION
      SELECT CAST("2017-06-28" AS DATE) as created, 0.70 as accuracy_matcher, 8 as control

      order by created desc
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: created {
    type: date
    sql: ${TABLE}.created ;;
  }

  measure: accuracy_matcher {
    type: number
    sql: ${TABLE}.accuracy_matcher ;;
    value_format_name: percent_2
  }

  measure: control {
    type: number
    sql: ${TABLE}.control ;;
  }

  set: detail {
    fields: [created, accuracy_matcher, control]
  }
}
