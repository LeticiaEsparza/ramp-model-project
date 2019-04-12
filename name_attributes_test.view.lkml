view: name_attributes_test {
  derived_table: {
    sql: SELECT "Brooke" first_name, "Davis" last_name, "designer" occupation, "Clothes Over Bros" company, '1' id_string
      UNION ALL
      SELECT "Peyton" first_name, "Sawyer" last_name, "artist" occupation, "Red Bedroom Records" company, '2' id_string
      UNION ALL
      SELECT "Lucas" first_name, "Scott" last_name, "writer" occupation, null company, '3' id_string
      UNION ALL
      SELECT "Nathan" first_name, "Scott" last_name, "athlete" occupation, "NBA" company, '4' id_string
      UNION ALL
      SELECT "Leticia" first_name, "Esparza" last_name, "analyst" occupation, "Looker" company, '5' id_string
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

  dimension: id_string {
    type: string
    sql: ${TABLE}.id_string ;;

  }

  set: detail {
    fields: [first_name, last_name, occupation]
  }
}
