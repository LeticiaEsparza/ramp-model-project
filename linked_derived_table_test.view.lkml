view: linked_derived_table_test {
  derived_table: {
    sql: -- use existing user_facts in sandbox_scratch.LR$X3YFNAGPFA3BBQ3HYDCGF_user_facts
      SELECT
        *
      FROM ${user_facts.SQL_TABLE_NAME}
       ;;
    sql_trigger_value: SELECT current_date;;
    indexes: ["user_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }

  dimension: first_order {
    type: string
    sql: ${TABLE}.first_order ;;
  }

  dimension: latest_order {
    type: string
    sql: ${TABLE}.latest_order ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: repeat_customer {
    type: string
    sql: ${TABLE}.repeat_customer ;;
  }

  dimension: days_since_first_purchase {
    type: number
    sql: ${TABLE}.days_since_first_purchase ;;
  }

  set: detail {
    fields: [
      user_id,
      total_orders,
      first_order,
      latest_order,
      created_at_time,
      repeat_customer,
      days_since_first_purchase
    ]
  }
}
