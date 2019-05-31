  view: dynamic_date_ndt {
    derived_table: {
      explore_source: derived_table_dynamic_date_filter {
        column: created_date {}
        filters: {
          field: derived_table_dynamic_date_filter.date_filter
          value: "1 months ago for 1 months"
        }
      }
    }
    dimension: created_date {
      type: date
    }
  }
