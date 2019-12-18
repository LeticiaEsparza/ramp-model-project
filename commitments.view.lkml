view: commitments {
  derived_table: {
    sql: SELECT "Value Diversity" AS commitment
      UNION ALL
      SELECT "Growth Mindset" AS commitment
      UNION ALL
      SELECT "Assume Positive Intent" AS commitment
      UNION ALL
      SELECT "Drive a Data Culture" AS commitment
      UNION ALL
      SELECT "Be Empowered" AS commitment
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: commitment {
    type: string
    sql: ${TABLE}.commitment ;;
  }

  set: detail {
    fields: [commitment]
  }
}
