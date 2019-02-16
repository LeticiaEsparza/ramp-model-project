- dashboard: look_27_dashboard
  title: Look 27 Dashboard
  layout: newspaper
  elements:
  - title: Filterable Value Example
    name: Filterable Value Example
    model: leticia_model_exercise
    explore: order_items
    type: table
    fields:
    - products.brand
    - orders.count
    filters:
      products.brand: "%^,%"
    sorts:
    - products.brand
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    row: 0
    col: 4
    width: 17
    height: 3
