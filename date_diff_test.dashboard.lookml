- dashboard: date_diff_test
  title: Date Diff Test
  layout: newspaper
  elements:
  - title: Date Diff Test
    name: Date Diff Test
    model: leticia_model_exercise
    explore: orders
    type: table
    fields:
    - orders.created_date
    - orders.days_since_order
    sorts:
    - orders.created_date desc
    limit: 500
    dynamic_fields:
    - table_calculation: calc_date_diff
      label: Calc Date Diff
      expression: diff_days(${orders.created_date}, now())
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 0
    col: 2
    width: 20
    height: 17
