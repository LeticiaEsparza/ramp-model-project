view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: test_id_case {
    type: string
    sql:
        CASE WHEN ${id} is null then null
             WHEN ${id}=1 then "first"
             WHEN ${id}=2 then "second"
             WHEN ${id} between 3 and 10 then "three through ten"
             WHEN ${id}>10 then "tester ten"
             ELSE "stuff"
        END
    ;;
  }


dimension: id_test {
  type: number
  sql: ${id} ;;
}

dimension: id_test_b {
  type: number
  sql: ${id} OR ${id_test} ;;
}

dimension: is_monday {
  type: yesno
  sql: ${created_day_of_week} = "Monday" ;;
}

  dimension: is_tuesday{
    type: yesno
    sql: ${created_day_of_week} = "Tuesday" ;;
  }


  dimension: week_day_list {
    type: string
    sql:
        CONCAT(
        CASE WHEN ${is_monday} THEN "Mon, "
        ELSE
        " "
        END,
        CASE WHEN ${is_tuesday} THEN "Tue, "
        ELSE
        " "
        END
        )
    ;;
  }

  # COUNT ORDERS FROM START DATE AND END DATE OF A FILTER

  filter: date_filter {
    type: date
  }

  dimension: is_date_filter_start {
    type: yesno
    sql: ${orders.created_raw} = {% date_start date_filter %} ;;
  }

  dimension: is_date_filter_end {
    type: yesno
    sql: ${orders.created_raw} = {% date_end date_filter %} ;;
  }

  measure: count_date_start {
    type: count
    filters: {
      field: is_date_filter_start
      value: "yes"
    }
  }

  measure: count_date_end {
    type: count
    filters: {
      field: is_date_filter_end
      value: "yes"
    }
  }

  # END OF EXAMPLE

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      date,
      day_of_week,
      day_of_week_index,
      week,
      month,
      quarter,
      year,
      day_of_month,
      month_name,
      month_num,
      day_of_year,
      hour6
    ]
    sql: ${TABLE}.created_at ;;
    allow_fill: yes
    # html:
    #       {% if orders.created_date._in_query %}
    #       {{orders.date_formatter._rendered_value}}
    #       {% else %}
    #       {{value}}
    #       {% endif %}
    # ;;
  }

  dimension_group: hour8 {
    type: time
    timeframes: [hour8]
    sql: ${TABLE}.created_at ;;
    html: {{ rendered_value | date: "%H" }} ;;
  }

dimension: hour8_single {
  type: date_hour8
  sql: ${TABLE}.created_at  ;;
  html: {{ rendered_value | date: "%H" }} ;;
}

  dimension: minute_15{
    type: date_minute15
    sql: ${TABLE}.created_at  ;;
  }

dimension: date_example {
  type: date
  sql: ${TABLE}.created_at  ;;
  html: {{ rendered_value | date: "%B %e, %Y" }} ;;
}

dimension: time_hour {
  type: date_time
  sql: ${created_time} ;;
  html: {{ rendered_value | date: "%I %p"}} ;;
}

  dimension: time_hour_of_day {
    type: date_time_of_day
    sql: ${TABLE}.created_at ;;
    html: {{ rendered_value | date: "%H:%M %p"}} ;;
  }

  dimension: day_of_week {
    type: date_day_of_week
    sql: CURDATE() ;;

  }

  dimension: assign_date {
    type: date
    sql: ${TABLE}.created_at;;
    html:
      {% assign first_date = '2019-01-01' | date: '%Y-%m-%d' %}
      {% assign date_field = value | date: '%Y-%m-%d' %}
      {% if date_field >= first_date %}
          "Win"
      {% else %}
          "Lose"
      {% endif %}
  ;;

  }

  dimension: olivias_test {
    description: "Grabs last month of last quarter"
    type: yesno
    sql: (EXTRACT(MONTH FROM ${orders.created_date})) = (EXTRACT(MONTH FROM DATE_SUB((MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE()) QUARTER - INTERVAL 1 QUARTER), INTERVAL 1 DAY)))
          AND (EXTRACT(YEAR FROM ${orders.created_date})) = (EXTRACT(YEAR FROM CURDATE())) ;;
  }

  dimension: date_is_now {
    type: date_raw
    sql: CAST(${TABLE}.created_at AS date);;
    html:
    {% assign now_value = "today" | date: "%Y-%m-%d" %}
    {% assign date_value = value | date: "%Y-%m-%d" %}
    {% if date_value == now_value %}
    <div style=" background-color: #d36b6b">{{ rendered_value }}</div>
    {% else %}
    <div style=" background-color: #79b288">{{ rendered_value }}</div>
    {% endif %}
    ;;
  }

parameter: date_selector {
  type: date
}

dimension: is_month_of_date_selected {
  type: yesno
  sql: MONTH(${orders.created_date}) = MONTH({% parameter date_selector %}) ;;
}

dimension: date_selector_dim {
  type: date
  sql: {% parameter date_selector %} ;;
}

dimension: is_one_month_before_date_selected {
  type: yesno
  sql: MONTH(${orders.created_date}) = MONTH(DATE_SUB({% parameter date_selector %} , INTERVAL 1 MONTH)) ;;
}

dimension: days_since_order {
  type: number
  sql: DATEDIFF(CURDATE(), ${created_date}) ;;
}

parameter: compare_date {
  type: date
}

dimension: days_since_order_dynamic {
  type: number
  sql: DATEDIFF({% parameter compare_date %}, ${created_date}) ;;
}

  measure: count_weekday{
    type: count
    filters: {
      field: orders.created_day_of_week
      value: "Monday, Tuesday, Wednesday, Thursday, Friday"
    }
  }

measure: number_measures_test {
  type: number
  sql: ${count_weekday}/${count} ;;
}
# format date field while preserving date functionality
  dimension: date_formatter {
    type: string
    sql: DATE_FORMAT(${created_date}, "%d/%m/%Y" );;
  }

  dimension: date_new_format {
    type: date
    sql: ${created_date} ;;
    html: {{orders.date_formatter._rendered_value}} ;;
  }
# end of example formatting date field


dimension_group: created_other_date{
  type: time
  timeframes: [
    raw,
    time,
    time_of_day,
    date,
    day_of_week,
    day_of_week_index,
    week,
    month,
    quarter,
    year,
    day_of_month,
    month_name,
    day_of_year
  ]
  sql: DATE_ADD(DATE_ADD(DATE_ADD(DATE_ADD(${created_raw}, INTERVAL 3 DAY), INTERVAL 9 HOUR), INTERVAL 35 MINUTE), INTERVAL 46 SECOND) ;;
}

#   measure: last_updated_date {
# #     type: date
#     sql: (SELECT MAX(orders.created_at) FROM demo_db.orders WHERE status="complete") ;;
#     convert_tz: no
#   }

dimension:  date_churn_diff {
  type: number
  sql: TIMESTAMPDIFF(SECOND,${created_raw},${created_other_date_raw})/86400.0;;
  value_format: "[h]:mm:ss"
# [h] format counts all hours while hh counts only the hours of day
# value_format: "[h]:mm:ss"
}

  dimension:  date_churn_diff_tier {
    type: tier
    style: integer
    sql: TIMESTAMPDIFF(SECOND,${created_raw},${created_other_date_raw})/86400.0;;
    tiers: [0,1,3,6,9,12,15,18,21,24,36,48,60]

  }

  parameter: date_sandwich {
    type: date
  }

  # filter: date_sandwich_filter {
  #   type: date
  #   sql:  ;;
  # }

  dimension: is_between_dates {
    type: yesno
    sql: {% parameter date_sandwich %} BETWEEN ${created_date} AND ${created_other_date_date};;
}

  dimension:  date_churn_diff_2 {
    type: number
    sql: TIMESTAMPDIFF(SECOND,${created_raw},${created_other_date_raw})/86400.0;;
    value_format: "hh:mm:ss"
  }

dimension_group: duration {
  type: duration
  sql_start: ${created_raw};;
  sql_end: ${created_other_date_raw};;
  intervals: [hour,minute,second,day]
}
# dimension_group: diff_duration{}

# measure:  avg_duration {
#   type: average
#   sql: ${duration_minute} ;;
# }

dimension: duration_dim {
  type: number
  sql: ${days_duration} ;;
}

filter: date_start_filter {
  type: date
}

dimension: date_start_test {
  type: date
  sql: {% date_start  date_start_filter %} ;;
  html: The start date is {{rendered_value}} ;;
}

measure: avg_duration_2 {
  type: average
  sql: ${date_churn_diff} ;;
}


  dimension: date_field_test {
    type: date
    sql: ${created_date} ;;
    html: <a href="https://localhost:9999/dashboards/18?date={{ value | date: "%s" | minus : 1209600 | date: "%Y-%m-%d"}}+to+{{value}}">
    Current: {{rendered_value}} Two weeks ago: {{ value | date: "%s" | minus : 1209600 | date: "%Y-%m-%d"}}</a> ;;
  }

dimension: is_in_past_2_weeks{
  type: yesno
  sql:
        ${users.created_date} >= DATE_SUB(${date_field_test}, INTERVAL 2 WEEK)

  ;;
}


  # sql: DATE_FORMAT(${created_date}, "%d/%m/%Y" );

# dimension: date_format_test_b {
#   type: date
#   sql:  ;;
# }
  # dimension: station_id {
  #   type: date
  #   sql: ${date_format_test};;
  #   html: <p style="font-size:30px"> {{value}} </p> ;;
  # }
# dimension: created_quarters_test {
#   type: date
#   sql: DATE_SUB(${created_date}, INTERVAL 1 QUARTER);;
# }

dimension_group: previous_quarter_test {
  type: time
  timeframes: [quarter]
  sql: DATE_SUB(${created_date}, INTERVAL 1 QUARTER);;
}

  dimension: thisvslast {
    type: yesno
    sql: ${created_quarter} = ${previous_quarter_test_quarter} ;;
  }

dimension: month_and_day {
  type: string
  sql: CONCAT(${created_month_name}," ",${created_day_of_month}) ;;
}


# dimension: created_string {
#   type: string
#   sql: ${created_quarter} ;;
# }
#
# dimension: quarter_test {
#   type: string
#   case: {
#     when: {
#       sql: ${created_string} LIKE '%-01%'  ;;
#       label: "Q1"
#     }
#     when: {
#       sql: ${created_string} LIKE '-%04%' ;;
#       label: "Q2"
#     }
#     when: {
#       sql: ${created_string} LIKE '%-07%' ;;
#       label: "Q3"
#     }
#     # Possibly more when statements
#     else: "Q4"
#   }
# }

measure: date_count {
  type: count
  filters:  {
    field: created_date
    value: "7 days"
  }
}

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


# measure: count_user_id {
#   type: count
#   sql: ${user_id} ;;
# }
 # measure: first_order {
  #  type: min
  #  sql: ${created_date};;
   # drill_fields: [users.id, users.full_name, products.category]
  #}

  measure: first_order {
    type: date
    sql: min(${created_date});;
    drill_fields: [users.id, users.full_name, products.category]
  }

measure: last_order {
  type: date
  sql: max(${created_date}) ;;
  drill_fields: [users.id, users.full_name, products.category]
}

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count, date_field_test, created_date]
  }

  measure: count_example {
    type: count
    drill_fields: [orders.id,orders.created_date,orders.created_quarter,orders.status,orders.user_id,order_items.total_profit]
    html: <p style="font-size: 100px">{{linked_value}}</p> ;;
    #html:<p style="font-size: 15px"><a href="{{link}}" target="_self"> {{rendered_value}} </a></p>;;
  }
    #html: <a href="/explore/leticia_model_exercise/order_items?fields=orders.id,orders.created_date,orders.created_quarter,orders.status,orders.user_id,order_items.total_profit">{{rendered_value}}</b> ;;

measure: count_sql {
  type: number
  sql: COALESCE(COUNT(DISTINCT ${id}),0) ;;
}

measure: count_dupe {
  type: number
  sql: COALESCE(${count},0) ;;
}
  #parameter practice

  parameter: date_granularity {
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }

  dimension: date_granularity_test {
    label_from_parameter: date_granularity
    sql:
       CASE
         WHEN {% parameter date_granularity %} = 'Day' THEN
           ${created_date}
         WHEN {% parameter date_granularity %} = 'Month' THEN
           ${created_month}
         WHEN {% parameter date_granularity %} = 'Quarter' THEN
           ${created_quarter}
         WHEN {% parameter date_granularity %} = 'Year' THEN
           ${created_year}
         ELSE
           NULL
       END ;;
  }

  parameter: test_date_curl {
    type: date_time
  }

  dimension: date_granularity_output {
    type: string
    sql: {% parameter date_granularity %} ;;
  }

  dimension: curls_test {
    sql: {% parameter date_granularity %} ;;
  }

  dimension: date_test {
    type: date
    sql: ${created_date} ;;
  }

#templated filter example
filter: year_filter {
  type: number
}

dimension: status_satisfies_filter {
  type: yesno
  sql: {% condition year_filter %} ${created_year} {% endcondition %}  ;;
}

measure:templated_filter_year_count{
  type: count_distinct
  sql: {% condition year_filter %} ${created_year} {% endcondition %}  ;;
}

measure: count_year_filter {
  type: count
  filters: {
    field: created_year
    value: "2017"
  }
}



parameter: test_date_param {
  type: date_time
  suggest_dimension: created_date
}

filter: test_date_temp {
  type: string
  suggest_dimension: created_date
}

dimension: entry_for_date_test{
  type: date
#   sql: {% parameter test_date_param %};;
  sql: '{% condition test_date_temp %} ${created_date} {% endcondition %}';;
}



# dimension: entry_for_date_test_dash{
#   type: string
#   sql: ${TABLE}.{% parameter date_test_dashboard %}   ;;
# }

measure: count_last_quarter {
  type: count
  filters: {
    field: previous_quarter_test_quarter
    value: "last 10 years"
  }
}

measure: percentage_orders_2017_over_total {
  type: number
  sql: ${count_year_filter}/${count} ;;
}


  measure: count_viz {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [orders.created_date, order_items.total_sale_price]
    link: {
      label: "Show as scatter plot"
      url: "
      {% assign vis_config = '{
      \"stacking\"                  : \"\",
      \"show_value_labels\"         : false,
      \"label_density\"             : 25,
      \"legend_position\"           : \"center\",
      \"x_axis_gridlines\"          : true,
      \"y_axis_gridlines\"          : true,
      \"show_view_names\"           : false,
      \"limit_displayed_rows\"      : false,
      \"y_axis_combined\"           : true,
      \"show_y_axis_labels\"        : true,
      \"show_y_axis_ticks\"         : true,
      \"y_axis_tick_density\"       : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\"         : false,
      \"show_x_axis_ticks\"         : true,
      \"x_axis_scale\"              : \"auto\",
      \"y_axis_scale_mode\"         : \"linear\",
      \"show_null_points\"          : true,
      \"point_style\"               : \"circle\",
      \"ordering\"                  : \"none\",
      \"show_null_labels\"          : false,
      \"show_totals_labels\"        : false,
      \"show_silhouette\"           : false,
      \"totals_color\"              : \"#808080\",
      \"type\"                      : \"looker_scatter\",
      \"interpolation\"             : \"linear\",
      \"series_types\"              : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\"             : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\"             : \"#000000\",
      \"label_position\"    : \"left\",
      \"period\"            : 30,
      \"regression_type\"   : \"average\",
      \"series_index\"      : 1,
      \"show_label\"        : true,
      \"label_type\"        : \"string\",
      \"label\"             : \"30 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  dimension: filter_test_date_sano {
    type: date
    sql: CASE WHEN ${created_date} = "2018/03/01" THEN NULL
         ELSE ${created_date}
        END ;;
}

  measure: count_filter_date_sano{
    type: count
    filters: {
      field: orders.filter_test_date_sano
      value: "-NULL"
    }
  }

  dimension: last_day_of_previous_month {
    type: date
    sql: LAST_DAY(${created_date} - interval 1 month );;
  }

  dimension: this_month_plus_last_day_previous_month {
    type: date
    sql:
        CASE WHEN ${created_date} >= LAST_DAY(now() - interval 1 month ) THEN ${created_date}
        ELSE null END
    ;;
  }

filter: test_date_standard {
  type: date_time
  suggest_dimension: created_date
}

dimension: test_date_standard_dim{
  type: date_time
  sql: {% condition test_date_standard %} orders.created_date {% endcondition %};;
}


  measure: week_day_count {
    type: number
    sql: DATEDIFF(stop,start) - ((FLOOR(DATEDIFF(stop,start) / 7) * 2) +
      CASE WHEN DATE_PART(dow, start) - DATE_PART(dow, stop) IN (1, 2, 3, 4, 5) AND DATE_PART(dow, stop) != 0
      THEN 2 ELSE 0 END +
      CASE WHEN DATE_PART(dow, start) != 0 AND DATE_PART(dow, stop) = 0
      THEN 1 ELSE 0 END +
      CASE WHEN DATE_PART(dow, start) = 0 AND DATE_PART(dow, stop) != 0
      THEN 1 ELSE 0 END) ;;
  }

  parameter: date_parameter {
    type: string
    allowed_value: {
      label: "2018-06-18"
      value: "2018-06-18"
    }
    allowed_value: {
      label: "2018-06-17"
      value: "2018-06-17"
    }
    allowed_value: {
      label: "2018-06-16"
      value: "2018-06-16"
    }
  }

  dimension: days_since_user_signup {
    hidden: yes
    type: number
    sql: DATEDIFF(${created_raw}, ${users.created_raw});;
  }

  dimension: months_since_user_signup {
    type: number
    sql: FLOOR(${days_since_user_signup}/(30)) ;;
  }

  dimension: months_since_user_signup_tier {
    type: tier
    tiers: [1,3,6,12,24]
    style: integer
    sql: ${months_since_user_signup} ;;
  }

  measure: count_complete {
    type: count
    filters: {
      field: status
      value: "complete"
    }
  }

  measure: count_distinct {
    type: count_distinct
    sql_distinct_key: ${id} ;;
  }

}
#DAYOFWEEK
