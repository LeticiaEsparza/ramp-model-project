view: padded_numbers {
    derived_table: {
      sql: SELECT 1234 as test
              UNION ALL
              SELECT 123 as test
              UNION ALL
              SELECT 12 as test
              UNION ALL
              SELECT 1 as test
              UNION ALL
              SELECT 123 as test
               ;;

      sql_trigger_value: SELECT current_date;;
      indexes: ["test"]

    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: test_number {
      type: number
      sql: ${TABLE}.test ;;
    }

    dimension: test_number_padded {
      type: number
      sql: ${TABLE}.test ;;
      value_format: "*00000#"
    }

  dimension: test_number_padded_sql {
    type: string
    sql: CONCAT('SM-', LPAD(CAST(${TABLE}.test AS char), 5, '0' ));;
  }



    dimension: smaller_number {
      type: number
      sql:  ${test_number}*0.0000000000012345;;
    }

    dimension: smaller_number_string {
      type: string
      sql: CAST(${smaller_number} AS string) ;;
    }

    set: detail {
      fields: [test_number]
    }
  }
