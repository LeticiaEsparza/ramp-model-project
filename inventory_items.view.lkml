view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }


  measure: total_cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }

 # measure: total_profit {
   # type: number
   # sql: ${order_items.total_revenue} - ${TABLE}.total_cost ;;

  #}

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      time_of_day
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  dimension: pao_test {
    type: string
    sql: "test" ;;
    html:
            {% if products._in_query %}
              "yes"
            {% else %}
              "no"
            {% endif %}
      ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
}
