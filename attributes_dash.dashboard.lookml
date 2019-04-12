- dashboard: attributes_test
  title: Attributes Test
  layout: newspaper
  elements:
  - title: Names
    name: Names
    model: leticia_model_exercise
    explore: name_attributes_test
    type: table
    fields: [name_attributes_test.first_name, name_attributes_test.last_name]
    sorts: [name_attributes_test.first_name]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Attribute: name_attributes_test.last_name
    row: 0
    col: 5
    width: 14
    height: 4
  filters:
  - name: Attribute
    title: Attribute
    type: field_filter
    default_value: "{{ _user_attributes['last_name'] }}"
    allow_multiple_values: true
    required: false
    model: leticia_model_exercise
    explore: name_attributes_test
    listens_to_filters: []
    field: name_attributes_test.last_name
