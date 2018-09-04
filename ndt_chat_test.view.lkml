view: ndt_chat_test {
  derived_table: {
    explore_source: order_items {
      column: created_date { field: orders.created_date }
      column: count { field: orders.count }
      filters: {
        field: orders.created_date
        value: "2 weeks"
      }
    }
  }
  dimension: created_date {
    label: "User Orders Created Date"
    type: date
  }
  measure: count {
    label: "User Orders Count"
    type: number
  }
}
