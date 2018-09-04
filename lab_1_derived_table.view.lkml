view: lab_1_derived_table {
  derived_table: {
    sql:
      SELECT
        pdt_lab_1_orders.id  AS `pdt_lab_1_orders.id`,
        pdt_lab_1_b.name  AS `pdt_lab_1_b.name`,
        pdt_lab_1_b.state  AS `pdt_lab_1_b.state`,
        COALESCE(SUM(pdt_lab_1_orders.cost ), 0) AS `pdt_lab_1_orders.total_spent`,
        COUNT(DISTINCT pdt_lab_1_b.state ) AS count_distinct_state
      FROM ${pdt_lab_1_orders.SQL_TABLE_NAME} AS pdt_lab_1_orders
      LEFT JOIN ${pdt_lab_1_b.SQL_TABLE_NAME} AS pdt_lab_1_b ON pdt_lab_1_orders.id=pdt_lab_1_b.id

      GROUP BY 1,2,3
      ORDER BY COALESCE(SUM(pdt_lab_1_orders.cost ), 0) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: pdt_lab_1_orders_id {
    type: number
    sql: ${TABLE}.`pdt_lab_1_orders.id` ;;
  }

  dimension: pdt_lab_1_b_name {
    type: string
    sql: ${TABLE}.`pdt_lab_1_b.name` ;;
  }

  dimension: pdt_lab_1_b_state {
    type: string
    sql: ${TABLE}.`pdt_lab_1_b.state` ;;
  }

  dimension: pdt_lab_1_orders_total_spent {
    type: number
    sql: ${TABLE}.`pdt_lab_1_orders.total_spent` ;;
  }

  dimension: count_distinct_state {
    type: number
    sql: ${TABLE}.count_distinct_state ;;
  }

  measure: max_count_distinct {
    type: max
    sql: ${count_distinct_state} ;;
  }

  measure: average_total_spent {
    type: average
    sql: ${pdt_lab_1_orders_total_spent} ;;
  }

  measure: average_total_spent_ny {
    type: average
    sql: ${pdt_lab_1_orders_total_spent} ;;
    filters: {
      field: pdt_lab_1_b_state
      value: "New York"
    }
  }

  set: detail {
    fields: [pdt_lab_1_orders_id, pdt_lab_1_b_name, pdt_lab_1_b_state, pdt_lab_1_orders_total_spent]
  }
}
