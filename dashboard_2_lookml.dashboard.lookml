
  title: Second Ramp Dash
  layout: newspaper
  elements:
  - title: Number of User Orders Per Quarter
    name: Number of User Orders Per Quarter
    model: leticia_model_exercise
    explore: order_items
    type: looker_bar
    fields:
    - orders.count
    - orders.created_quarter
    fill_fields:
    - orders.created_quarter
    sorts:
    - orders.created_quarter desc
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - "#5245ed"
    - "#ed6168"
    - "#1ea8df"
    - "#353b49"
    - "#17e3cc"
    - "#b3a0dd"
    - "#db7f2a"
    - "#706080"
    - "#a2dcf3"
    - "#776fdf"
    - "#e9b404"
    - "#635189"
    series_colors:
      orders.count: "#12cfdb"
    x_axis_label: Quarter
    y_axis_reversed: false
    row: 0
    col: 0
    width: 12
    height: 7
  - title: Profit Per Item by Product Category
    name: Profit Per Item by Product Category
    model: leticia_model_exercise
    explore: order_items
    type: looker_scatter
    fields:
    - order_items.profit
    - products.category
    sorts:
    - order_items.profit
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    show_null_points: true
    point_style: circle
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    y_axes:
    - label: ''
      maxValue: 3
      minValue: -3
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: order_items.profit
        name: Order Items Profit
    colors:
    - 'palette: Mixed Dark'
    series_colors:
      order_items.profit: "#059e00"
    label_rotation: -90
    x_axis_label_rotation: -60
    row: 0
    col: 12
    width: 12
    height: 7
  - title: Order Count per Month by Category
    name: Order Count per Month by Category
    model: leticia_model_exercise
    explore: order_items
    type: looker_area
    fields:
    - products.category
    - orders.count
    - orders.created_month
    pivots:
    - products.category
    fill_fields:
    - orders.created_month
    sorts:
    - products.category desc
    - orders.created_month desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    colors:
    - 'palette: Santa Cruz'
    series_colors: {}
    row: 7
    col: 12
    width: 12
    height: 8
  - title: Number of Orders by User Age
    name: Number of Orders by User Age
    model: leticia_model_exercise
    explore: order_items
    type: looker_scatter
    fields:
    - users.age
    - orders.count
    sorts:
    - orders.count desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    show_null_points: true
    point_style: circle
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - 'palette: Santa Cruz'
    series_colors: {}
    row: 7
    col: 0
    width: 12
    height: 8
  - title: Profit Per Category for Each Year
    name: Profit Per Category for Each Year
    model: leticia_model_exercise
    explore: order_items
    type: looker_donut_multiples
    fields:
    - orders.created_year
    - order_items.total_profit
    - products.category
    pivots:
    - products.category
    fill_fields:
    - orders.created_year
    sorts:
    - orders.created_year desc
    - products.category
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_value_labels: false
    font_size: 22
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    charts_across: 240
    hide_legend: false
    colors: 'palette: Santa Cruz'
    series_colors: {}
    row: 15
    col: 0
    width: 24
    height: 8
  - title: Month User Account was Created by Number of Users
    name: Month User Account was Created by Number of Users
    model: leticia_model_exercise
    explore: order_items
    type: looker_funnel
    fields:
    - users.created_month
    - users.count
    fill_fields:
    - users.created_month
    sorts:
    - users.created_month desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    leftAxisLabelVisible: true
    leftAxisLabel: User Account Month Created
    rightAxisLabelVisible: true
    rightAxisLabel: User Count
    barColors:
    - red
    - blue
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: true
    labelColor: "#d80606"
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 23
    col: 0
    width: 13
    height: 9
  - title: Total Profit
    name: Total Profit
    model: leticia_model_exercise
    explore: order_items
    type: single_value
    fields:
    - order_items.total_profit
    - order_items.total_revenue
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 23
    col: 13
    width: 11
    height: 4
  - title: Most Profitable Jeans
    name: Most Profitable Jeans
    model: leticia_model_exercise
    explore: order_items
    type: looker_single_record
    fields:
    - order_items.profit
    - products.brand
    - products.category
    - products.department
    - products.id
    - products.item_name
    - products.rank
    - products.retail_price
    - products.sku
    filters:
      products.category: Jeans
    sorts:
    - order_items.profit desc
    limit: 1
    column_limit: 50
    show_view_names: true
    note_state: collapsed
    note_display: below
    note_text: Looking at most profitable jeans because jeans appear to be the most
      profitable category
    row: 27
    col: 13
    width: 11
    height: 5
  - title: Interactive Map Focusing on CA
    name: Interactive Map Focusing on CA
    model: leticia_model_exercise
    explore: users
    type: looker_map
    fields:
    - users.zip
    - users.count
    sorts:
    - users.count desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: true
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    map_latitude: 36.31512514748051
    map_longitude: -122.32177734375001
    map_zoom: 5
    row: 32
    col: 0
    width: 13
    height: 8
  - title: Static Map for Order Amounts
    name: Static Map for Order Amounts
    model: leticia_model_exercise
    explore: order_items
    type: looker_geo_choropleth
    fields:
    - orders.count
    - users.state
    sorts:
    - orders.count desc
    limit: 500
    column_limit: 50
    map: auto
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    row: 32
    col: 13
    width: 11
    height: 8
