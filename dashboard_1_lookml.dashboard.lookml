- dashboard: ramp_model_exercise
  title: Ramp Model Exercise
  layout: newspaper
  elements:
  - title: Amount of Orders Categorized in Profit Tier
    name: Amount of Orders Categorized in Profit Tier
    model: leticia_model_exercise
    explore: order_items
    type: looker_pie
    fields:
    - order_items.profit_tier
    - order_items.count
    fill_fields:
    - order_items.profit_tier
    sorts:
    - order_items.profit_tier
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    show_value_labels: false
    font_size: 12
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors:
    - red
    - blue
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
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
    show_null_points: true
    point_style: circle
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors: 'palette: Santa Cruz'
    series_colors: {}
    inner_radius: 40
    row: 0
    col: 15
    width: 9
    height: 7
  - title: Profit, Revenue, and Average by Product Category
    name: Profit, Revenue, and Average by Product Category
    model: leticia_model_exercise
    explore: order_items
    type: looker_column
    fields:
    - products.category
    - order_items.avg_order
    - order_items.total_profit
    - order_items.total_revenue
    sorts:
    - order_items.avg_order desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 22
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
    y_axes:
    - label: Total Profit
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: custom
      tickDensityCustom: 15
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: order_items.total_profit
        name: Order Items Total Profit
    - label: Order Average
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: custom
      tickDensityCustom: 0
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: order_items.avg_order
        name: Order Items Order Sale Average
    - label: Total Revenue
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: custom
      tickDensityCustom: 15
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: order_items.total_revenue
        name: Order Items Total Revenue
    colors:
    - 'palette: Santa Cruz'
    series_colors: {}
    hidden_series: []
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    series_types: {}
    x_axis_label_rotation: -70
    reference_lines: []
    row: 0
    col: 0
    width: 15
    height: 7
  - title: Number of Returned Items by Category
    name: Number of Returned Items by Category
    model: leticia_model_exercise
    explore: order_items
    type: looker_line
    fields:
    - order_items.was_item_returned
    - order_items.count
    - products.category
    filters:
      order_items.was_item_returned: 'Yes'
    sorts:
    - order_items.count desc
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
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Mixed Dark'
    series_colors:
      order_items.count: "#e33c07"
    series_types: {}
    hide_legend: false
    x_axis_label: Product Category
    y_axes:
    - label: Returns
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: order_items.count
        name: Order Items Count
    note_state: collapsed
    note_display: below
    note_text: The jeans category has the highest amount of returns, but also has
      one of the highest total profits.
    row: 7
    col: 0
    width: 13
    height: 8
  - title: Timeline from Date Order was Created to Date Returned
    name: Timeline from Date Order was Created to Date Returned
    model: leticia_model_exercise
    explore: order_items
    type: looker_timeline
    fields:
    - users.full_name
    - users.created_date
    - order_items.returned_date
    filters:
      order_items.was_item_returned: 'Yes'
    sorts:
    - users.created_date desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    barColors:
    - 'palette: Santa Cruz'
    groupBars: true
    labelSize: 10pt
    showLegend: true
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
    row: 15
    col: 0
    width: 24
    height: 8
  - title: Order Item Count for Profit Tiers and Product Category
    name: Order Item Count for Profit Tiers and Product Category
    model: leticia_model_exercise
    explore: order_items
    type: table
    fields:
    - order_items.profit_tier
    - products.category
    - order_items.count
    pivots:
    - order_items.profit_tier
    fill_fields:
    - order_items.profit_tier
    sorts:
    - order_items.profit_tier
    - order_items.count desc 0
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    series_labels:
      order_items.profit_tier: Profit Tier
    row: 23
    col: 0
    width: 24
    height: 8
  - title: Points Chart for Number of Users per Zip
    name: Points Chart for Number of Users per Zip
    model: leticia_model_exercise
    explore: order_items
    type: looker_geo_coordinates
    fields:
    - users.count
    - users.zip
    sorts:
    - users.count desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    map: usa
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
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
    row: 7
    col: 13
    width: 11
    height: 8
