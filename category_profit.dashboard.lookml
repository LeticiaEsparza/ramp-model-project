- dashboard: profit_per_category
  title: Profit Per Category
  layout: newspaper
  elements:
  - name: Profit per Category Over Time
    title: Profit per Category Over Time
    model: leticia_model_exercise
    explore: order_items
    type: looker_area
    fields:
    - products.category
    - orders.created_quarter
    - order_items.total_profit
    pivots:
    - products.category
    fill_fields:
    - orders.created_quarter
    sorts:
    - orders.created_quarter desc
    - products.category
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    y_axis_reversed: false
    hide_legend: true
    row: 0
    col: 2
    width: 20
    height: 10
