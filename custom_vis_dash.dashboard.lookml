- dashboard: custom_visualizations_lab_example
  title: Custom Visualizations Lab Example
  layout: newspaper
  elements:
  - name: Sunburst Example
    title: Sunburst Example
    model: leticia_model_exercise
    explore: order_items
    type: sunburst
    fields:
    - products.category
    - products.department
    - products.count
    - products.brand
    sorts:
    - products.count desc
    limit: 100
    column_limit: 50
    color_range:
    - "#dd3333"
    - "#80ce5d"
    - "#f78131"
    - "#369dc1"
    - "#c572d3"
    - "#36c1b3"
    - "#b57052"
    - "#ed69af"
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 15
    width: 8
    height: 8
  - name: Treemap Example
    title: Treemap Example
    model: leticia_model_exercise
    explore: order_items
    type: treemap
    fields:
    - products.category
    - products.department
    - order_items.total_profit
    sorts:
    - products.category
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 10
    col: 3
    width: 19
    height: 9
  - name: Sankey Example
    title: Sankey Example
    model: leticia_model_exercise
    explore: order_items
    type: sankey
    fields:
    - users.city
    - users.state
    - users.count
    - users.country
    sorts:
    - users.count desc
    limit: 20
    query_timezone: America/Los_Angeles
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
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
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    row: 0
    col: 1
    width: 14
    height: 8
  - name: Subtotal Example
    title: Subtotal Example
    model: leticia_model_exercise
    explore: order_items
    type: Subtotal
    fields:
    - products.category
    - products.department
    - order_items.total_profit
    - orders.created_week
    pivots:
    - products.department
    filters:
      orders.created_date: 4 weeks ago for 4 weeks
    sorts:
    - order_items.total_profit desc 0
    - products.department
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 21
    col: 3
    width: 19
    height: 13
  - name: title_1
    type: text
    body_text: <font color="black" size ="5"><center>Notes on Sankey Vis</center></font>
    row: 8
    col: 1
    width: 14
    height: 2
  - name: title_2
    type: text
    body_text: <font color="black" size ="5"><center>Notes on Sunburst Vis</center></font>
    row: 8
    col: 15
    width: 8
    height: 2
  - name: title_3
    type: text
    body_text: <font color="black" size ="5"><center>Notes on Treemap Vis</center></font>
    row: 19
    col: 3
    width: 19
    height: 2
  - name: title_4
    type: text
    body_text: <font color="black" size ="5"><center>Notes on Subtotal Vis</center></font>
    row: 34
    col: 3
    width: 19
    height: 2
