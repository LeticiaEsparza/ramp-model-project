view: name_attributes_test {
  derived_table: {
    sql: SELECT "Brooke" first_name, "Davis" last_name
      UNION ALL
      SELECT "Peyton" first_name, "Sawyer" last_name
      UNION ALL
      SELECT "Lucas" first_name, "Scott" last_name
      UNION ALL
      SELECT "Nathan" first_name, "Scott" last_name
      UNION ALL
      SELECT "Leticia" first_name, "Esparza" last_name
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  set: detail {
    fields: [first_name, last_name]
  }
}
