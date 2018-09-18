view: name_attributes_test {
  derived_table: {
    sql: SELECT "Brooke" first_name, "Davis" last_name, "designer" occupation, "Clothes Over Bros" company
      UNION ALL
      SELECT "Peyton" first_name, "Sawyer" last_name, "artist" occupation, "Red Bedroom Records" company
      UNION ALL
      SELECT "Lucas" first_name, "Scott" last_name, "writer" occupation, null company
      UNION ALL
      SELECT "Nathan" first_name, "Scott" last_name, "athlete" occupation, "NBA" company
      UNION ALL
      SELECT "Leticia" first_name, "Esparza" last_name, "analyst" occupation, "Looker" company
       ;;
    sql_trigger_value: SELECT current_date;;
    indexes: ["first_name"]
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

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  set: detail {
    fields: [first_name, last_name, occupation]
  }
}
