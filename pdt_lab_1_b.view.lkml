view: pdt_lab_1_b {
  derived_table: {
    sql: SELECT 1 id, "Lucas" name, "California" state
      UNION ALL
      SELECT 2 id, "Nathan" name, "California" state
      UNION ALL
      SELECT 3 id, "Hailey" name, "North Carolina" state
      UNION ALL
      SELECT 4 id, "Blaire" name, "New York" state
      UNION ALL
      SELECT 5 id, "Brooke" name, "New York" state
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

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count_distinct_state {
    type: count_distinct
    sql: ${state} ;;
  }
  set: detail {
    fields: [id, name, state]
  }
}
