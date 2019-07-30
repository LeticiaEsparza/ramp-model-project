view: ally_dvm_test {
  derived_table: {
    sql:
      {% assign date_threshold = date_param._parameter_value | date: "%Y-%m-%d" %}
      SELECT
        DATE(orders.created_at ) AS created_date
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id

      WHERE orders.created_at >= DATE("{{ date_threshold }}")

      GROUP BY 1
      ORDER BY DATE(orders.created_at ) DESC
      LIMIT 500
       ;;
  }

  parameter: date_param {
    type: date
  }

#        {% assign date_threshold = '2019-05-01' | date: '%Y-%m-%d' %}

  dimension: test {
    type: date
    sql: {% assign date_threshold = "2019-04-01" | date: "%Y-%m-%d" %} "{{ date_threshold }}" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }

  set: detail {
    fields: [created_date]
  }
}
