view: user_cohort_size {
  derived_table:
  {
  sql:
      SELECT
        DATE_FORMAT(CONVERT_TZ(created_at,'UTC','America/Los_Angeles'),'%Y-%m') AS created_month
        , COUNT(*) as cohort_size
      FROM users
      WHERE
        -- Insert filters here using a condition statement, you may add as many filters as desired
        {% condition users.age %} users.age {% endcondition %}
        AND {% condition users.state %} users.state {% endcondition %}
      GROUP BY 1 ;;


    indexes: ["created_month"]
    }

    dimension: created_month {
      primary_key: yes
      sql: ${TABLE}.created_month ;;
    }

    dimension: cohort_size {
      type: number
      sql: ${TABLE}.cohort_size ;;
    }

    measure: total_cohort_size {
      type: sum
      sql: ${cohort_size} ;;
      }

    measure: total_revenue_over_total_cohort_size {
      type: number
      sql: ${order_items.total_sale_price} / ${total_cohort_size} ;;
      value_format_name: usd
      }
}
