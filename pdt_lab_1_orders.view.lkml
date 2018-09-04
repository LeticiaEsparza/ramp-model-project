view: pdt_lab_1_orders {
  derived_table: {
    sql: SELECT 1 id, 10 as cost
      UNION ALL
      SELECT 1 id, 20 as cost
      UNION ALL
      SELECT 1 id, 30 as cost
      UNION ALL
      SELECT 2 id, 40 as cost
      UNION ALL
      SELECT 2 id, 50 as cost
      UNION ALL
      SELECT 2 id, 60 as cost
      UNION ALL
      SELECT 3 id, 70 as cost
      UNION ALL
      SELECT 3 id, 80 as cost
      UNION ALL
      SELECT 3 id, 90 as cost
      UNION ALL
      SELECT 4 id, 100 as cost
      UNION ALL
      SELECT 4 id, 110 as cost
      UNION ALL
      SELECT 4 id, 120 as cost
      UNION ALL
      SELECT 5 id, 130 as cost
      UNION ALL
      SELECT 5 id, 140 as cost
      UNION ALL
      SELECT 5 id, 150 as cost
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

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  measure: total_spent {
    type: sum
    sql: ${cost} ;;
  }

  set: detail {
    fields: [id, cost]
  }
}
