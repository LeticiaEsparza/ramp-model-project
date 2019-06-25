view: boolean_test {
  derived_table: {
    sql: SELECT TRUE as boolean, "happy" as emotion
      UNION ALL
      SELECT FALSE as boolean, "happy" as emotion
      UNION ALL
      SELECT TRUE as boolean, "sad" as emotion
      UNION ALL
      SELECT FALSE as boolean, "sad" as emotion
      UNION ALL
      SELECT TRUE as boolean, "love" as emotion
      UNION ALL
      SELECT FALSE as boolean, "love" as emotion
      UNION ALL
      SELECT TRUE as boolean, "hate" as emotion
      UNION ALL
      SELECT FALSE as boolean, "hate" as emotion
      UNION ALL
      SELECT TRUE as boolean, "anger" as emotion
      UNION ALL
      SELECT FALSE as boolean, "anger" as emotion
      UNION ALL
      SELECT TRUE as boolean, "joy" as emotion
      UNION ALL
      SELECT FALSE as boolean, "joy" as emotion
      UNION ALL
      SELECT null as boolean, "blegh" as emotion
      UNION ALL
      SELECT null as boolean, "blegh" as emotion

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: boolean {
    type: number
    sql: ${TABLE}.boolean ;;
  }

#   sql: IFNULL(${TABLE}.boolean, "Null") ;;
#   html: <p style="color: #166088; background-color: #B3F5F7; font-size: 200%; text-align:center">{{value}}</p> ;;

  dimension: emotion {
    type: string
    sql: ${TABLE}.emotion ;;
  }

  dimension: boolean_yesno {
    type: yesno
    sql: ${boolean} ;;
  }

  measure: count_yes {
    type: count
    filters: {
      field: boolean_yesno
      value: "yes"
    }
  }

  measure: count_no {
    type: count
    filters: {
      field: boolean_yesno
      value: "no"
    }
  }

  set: detail {
    fields: [boolean, emotion]
  }
}
