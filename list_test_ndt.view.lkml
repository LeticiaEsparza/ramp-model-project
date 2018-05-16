view: list_test_ndt {
  derived_table: {
    explore_source: order_items {
      column: id { field: orders.id }
      column: department { field: products.department }
      column: list_category { field: products.list_category }
    }
  }
  dimension: id {
    label: "User Orders ID"
    type: number
  }
  dimension: department {}
  dimension: list_category {
    type: string
    html:
    {% if value contains "|RECORD|" %}
    {{ value | replace: '|RECORD|', ', ' }}
    {% else %}
    {{value}}
    {% endif %}
    ;;
  }
}
