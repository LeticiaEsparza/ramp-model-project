view: sql_runner_query {
  derived_table: {
    sql: SELECT 0 as example
      UNION ALL
      SELECT 0 as example
      UNION ALL
      SELECT 0 as example
      UNION ALL
      SELECT 0 as example
      UNION ALL
      SELECT "t1" as example
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: example {
    type: string
    sql: ${TABLE}.example ;;
  }

measure: test {
  type: sum
  sql:
      CASE WHEN ${example} is NULL
      THEN 0
      ELSE 1
      END
  ;;
  filters: {
    field: example
    value: "t1"
  }
}

dimension: sumtest {
  type: number
  sql: 1/NULLIF(${example},0) ;;
}

  set: detail {
    fields: [example]
  }
}
