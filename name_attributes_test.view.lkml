view: name_attributes_test {
  derived_table: {
    sql: SELECT "Brooke" first_name, "Davis" last_name, "designer" occupation
      UNION ALL
      SELECT "Peyton" first_name, "Sawyer" last_name, "artist" occupation
      UNION ALL
      SELECT "Lucas" first_name, "Scott" last_name, "writer" occupation
      UNION ALL
      SELECT "Nathan" first_name, "Scott" last_name, "athlete" occupation
      UNION ALL
      SELECT "Leticia" first_name, "Esparza" last_name, "analyst" occupation
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

  dimension: occupation {
    type: string
    sql: ${TABLE}.occupation ;;
  }

  set: detail {
    fields: [first_name, last_name, occupation]
  }
}
