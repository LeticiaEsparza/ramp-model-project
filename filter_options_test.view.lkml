view: filter_options_test {
  derived_table: {
    sql: SELECT TIMESTAMP('2018-08-01') created_dt, MONTH(DATE('2018-08-01')) created_m
      UNION ALL
      SELECT TIMESTAMP('2018-08-02') created, MONTH(DATE('2018-08-02')) created_m
      UNION ALL
      SELECT TIMESTAMP('2018-08-03') created, MONTH(DATE('2018-08-03')) created_m
      UNION ALL
      SELECT TIMESTAMP('2018-08-04') created, MONTH(DATE('2018-08-04')) created_m
      UNION ALL
      SELECT TIMESTAMP('2018-08-05') created, MONTH(DATE('2018-08-05')) created_m
      UNION ALL
      SELECT TIMESTAMP('2018-08-06') created, MONTH(DATE('2018-08-06')) created_m
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: created_dt {
    type: time
    sql: ${TABLE}.created_dt ;;
    timeframes: [
      date,
      month,
      month_num,
      year,
      week,
      quarter,
      time
    ]
  }

  dimension: created_m {
    type: number
    sql: ${TABLE}.created_m ;;
  }

  set: detail {
    fields: [created_dt_time, created_m]
  }
}
