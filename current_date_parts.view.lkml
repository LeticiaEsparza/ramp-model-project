view: current_date_parts {
  derived_table: {
    sql: SELECT CURDATE() AS current, EXTRACT(YEAR FROM CURDATE()) AS year, EXTRACT(MONTH FROM CURDATE()) AS month, EXTRACT(DAY FROM CURDATE()) AS day
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: current {
    type: date
    sql: ${TABLE}.current ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension: day {
    type: number
    sql: ${TABLE}.day ;;
  }

  dimension: current_test {
    type: date
    sql: CAST(CONCAT(CAST(${TABLE}.year AS char), '-', CAST(${TABLE}.month AS char),'-', CAST(${TABLE}.day AS char)) AS date) ;;
  }

  dimension: template {
    type: yesno
    sql: {% condition current_date_parts.current %} ${current_date_parts.current} {% endcondition %};;
  }

  filter: test_filter {
    type: date
  }

  set: detail {
    fields: [current, year, month, day]
  }
}
