view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
   # hidden: yes
    primary_key: yes
    #hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

measure: count_hidden{
  type: count_distinct
  sql: ${id} ;;
}

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

dimension: more_info {
  type: string
  sql: "For more information" ;;
  html: <a href="https://www.google.com/">{{ value }}</a> ;;
}

dimension: test_fake {
  type: string
  sql: ${TABLE}.flsifjslkjsd ;;
}

dimension: test_hard_insert {
  type: date
  sql: CURDATE();;

}

#test for Charlie 5/22/18
filter: test_filter_time {
  type: date_time
#  datatype: datetime
}

dimension: test_filter_time_date {
  type: date
  sql: {% condition test_filter_time %} ${orders.created_date} {% endcondition %};;
}

  dimension: test_filter_time_date_2 {
    type: date
    sql: {% condition orders.created_date %} ${orders.created_date} {% endcondition %};;
  }

measure: ratio_test {
  type: number
  sql: ${count}/${orders.count} ;;
  }
# filter: other_churn_days {
#   sql: ${products.churn_days} ;;
# }

  dimension: test {
    type:  number
    sql: CASE WHEN ${inventory_item_id} >= 50 THEN 50
      ELSE ${inventory_item_id} END;;
  }

measure: yn_test {
  type: yesno
  sql: ${returned_date}= CURDATE() ;;
}


  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
#TEST FOR PDT
  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

measure: count_dist_concat {
  type: count_distinct
  sql: CONCAT(${products.category},",",CAST(${orders.id} AS string)) ;;
}

measure: test_quotient{
  type: number
  sql: ${total_profit}/${total_revenue} ;;
  value_format: "0.00"
}

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  parameter: sale_price_threshold {
    type: number
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    html:
          {% assign threshold = sale_price_threshold._parameter_value | plus: 0 %}
          {% if value >= threshold %}
              <p style="color: green; font-weight: bold; text-align:center">{{rendered_value}}</p>
          {% else %}
              <p style="color: red; font-weight: bold; text-align:center">{{rendered_value}}</p>
          {% endif %}
    ;;
  }

  dimension: sale_price_tier {
    type: tier
    style: classic
    sql: ${TABLE}.sale_price ;;
    tiers: [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
  }

dimension: sale_price_pound {
  type: number
  sql: ${sale_price}*(0.74) ;;
  value_format_name: gbp
}

measure: total_sale_price {
  type: sum
#   sql: coalesce(${sale_price},0) ;;
  sql: ${sale_price} ;;
  value_format: "$#,##0.00"

}

measure: error {
  type: sum
  sql: ${sale_price} ;;
}

parameter: measure_choice {
  suggestions: ["sum", "count"]
}

measure: dynamic_aggregate {
  type: number
  sql: case when  {% condition measure_choice %} 'sum' {% endcondition %}  then sum(${sale_price})
    when {% condition measure_choice %} 'count' {% endcondition %}  then count(${sale_price})
    else null end ;;
}

measure: test_ratio_div {
  type: number
  sql: ${total_sale_price}/${profit} ;;
  # filters: {
  #   field: orders.category
  #   value: "%pants%"
  # }
}


# Dimension of type number
dimension: profit {
  type: number
  sql:  ${TABLE}.sale_price - ${inventory_items.cost} ;;
}

# Dimension of type case
dimension: profit_status {
  case: {
    when: {
      sql: ${profit} <= 0 ;;
      label: "Not Profitable"
    }
    else: "Profitable"
  }

}

#   dimension: profit_test {
#     type: string
#     sql: CASE WHEN ${profit_status}="Not Profitable" THEN 'yes'
#     ELSE 'no'
#     END;;
#   }


# Dimension of type tier
dimension: profit_tier {
  label: "Profit in Tiers"
  description: "Divides profit into 10 tiers in increments of 10"
  type: tier
  tiers: [0,10,20,30,40,50,60,70,80,100]
  style: classic
  sql: ${profit} ;;
  drill_fields: [users.id, users.full_name, products.category]


}
# measure: sum_count {
#   type: sum
#   sql: ${count} ;;
# }

# dimension: profit_test {
#   case: {
#     when: {
#       sql: ${profit}<25 ;;
#       label: "fall"
#     }
#     when: {
#       sql: ${profit}>=25 and ${profit}<50 ;;
#       label: "winter"
#     }
#     when: {
#       sql: ${profit}>=50 and ${profit}<75 ;;
#       label: "spring"
#     }
#     when: {
#       sql: ${profit}>=75 ;;
#       label: "summer"
#     }
#
#   }
# }

measure: validity{
  type:  number
  sql: ${total_profit}/${total_revenue} ;;
}

dimension: case_test  {
  case: {
    when: {
      sql: ${products.category}="pants" ;;
      label: "winner"
    }
    else: "loser"
  }
}
#average order - measure with average
measure: avg_order {
  label: "Order Sale Average"
  type: average
  sql: ${sale_price} ;;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

}

#average order items profit
measure: avg_item_profit {
  description: "Evaluates the average profit"
  type: average
  sql: ${profit} ;;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

}

#smallest item profit - measure with min
measure: smallest_item_profit {
  type: min
  sql: ${profit} ;;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

}

#smallest order
measure: smallest_order {
  description: "Identifies the smallest order by sale price in given query"
  type: min
  sql: ${sale_price} ;;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

}

#largest item profit - measure with max
  measure: largest_item_profit {
    description: "Identifies the largest order by sale price in given query"
    type: max
    sql: ${profit} ;;
    value_format_name: usd
    drill_fields: [users.id, users.full_name, products.category]

  }

#largest order
  measure: largest_order {
    type: max
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [users.id, users.full_name, products.category]

  }

# measure: test_filter_measure {
#   type: sum
#   sql: ${total_profit} ;;
#   filters: {
#     field: largest_order
#     value: ">10"
#   }
# }
measure: total_revenue {
  type: sum
  sql: ${sale_price};;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

  link: {
    label: "Table"
    url: "
    {% assign vis_config = '{

      \"type\":\"table\",
      \"show_view_names\":false,
      \"show_row_numbers\":true,
      \"truncate_column_names\":false,
      \"hide_totals\":false,
      \"hide_row_totals\":false,
      \"table_theme\":\"editable\",
      \"limit_displayed_rows\":false,
      \"enable_conditional_formatting\":false,
      \"conditional_formatting_include_totals\":false,
      \"conditional_formatting_include_nulls\":false

    }' %}
    {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"

  }

}

  measure: total_revenue_7_days{
    type: sum
    sql: ${sale_price};;
    value_format_name: usd
    drill_fields: [users.id, users.full_name, products.category]
    filters: {
      field: orders.created_date
      value: "7 days ago for 7 days"
    }
  }

  measure: total_revenue_1_week_ago {
    type: sum
    sql: ${sale_price};;
    value_format_name: usd
    drill_fields: [users.id, users.full_name, products.category]
    filters: {
      field: orders.created_date
      value: "1 week ago"
    }
  }

measure: total_revenue_example {
  type: sum
  sql: ${sale_price} ;;
  value_format_name: usd
  html: {{ rendered_value | replace: '.', 'µ' | replace: ',',' ' | replace: 'µ', ','}} ;;
}

measure: liquid_behavior_test{
  type: number
  sql:
      {% if user_facts.id._is_filtered  %} ${user_facts.total} {% else %} ${total_sale_price} {% endif %}
  ;;
  value_format: "$#,##0.00"
}

  measure: liquid_behavior_test_2{
    type: number
    sql:
      {% if orders.created_date._is_filtered  %} ${inventory_items.total_cost} {% else %} ${total_sale_price} {% endif %}
  ;;
    value_format: "$#,##0.00"
  }

measure: total_profit_example {
  type: number
  sql: ${total_revenue}-${inventory_items.total_cost} ;;
  value_format_name: usd
  html: <font color="green">{{rendered_value}}</font> ;;
}

  measure: total_profit_scatterplot {
    type: number
    sql: ${total_revenue}-${inventory_items.total_cost} ;;
    value_format_name: usd
    html: {{ products.category._rendered_value }} ;;
  }

  measure: total_profit_example_2 {
    type: number
    sql: ${total_revenue}-${inventory_items.total_cost} ;;
    value_format_name: usd
    html: <a href="/explore/leticia_model_exercise/order_items?fields=products.category,orders.count,inventory_items.total_cost,order_items.total_revenue,order_items.total_profit&f[order_items.total_profit]=>={{filterable_value}}">{{ rendered_value }}</a> ;;
  }

  measure: total_profit_logic {
    type: number
    sql: ${total_revenue}-${inventory_items.total_cost} ;;
    value_format_name: usd
    html: {% if value >= 75000 %}
            <font color="green">{{rendered_value}}</font>
          {% elsif value >= 50000 and value < 75000 %}
            <font color="goldenrod">{{rendered_value}}</font>
          {% else %}
            <font color="red">{{rendered_value}}</font>
          {% endif %}
    ;;
#     html: {% if products.category._in_query and value >= 75000 %}
#             <font color="green">{{rendered_value}}</font>
#           {% elsif products.category._in_query and value >= 50000 and value < 75000 %}
#             <font color="goldenrod">{{rendered_value}}</font>
#           {% elsif products.category._in_query %}
#             <font color="red">{{rendered_value}}</font>
#           {% else %}
#             {{rendered_value}}
#           {% endif %}
#     ;;
  }

measure: total_profit_logic_blegh {
    type: number
    sql: ${total_revenue}-${inventory_items.total_cost} ;;
    value_format_name: usd
    html: {% if value >= 75000 %}
            <font color="green">{{rendered_value}}</font>
          {% endif %}
    ;;
    }

measure: total_profit {
  label: "Total Profit"
  type: number
  sql: ${total_revenue}-${inventory_items.total_cost} ;;
  value_format_name: usd
#  drill_fields: [orders.created_quarter, order_items.total_revenue, order_items.total_profit]
#   html:
#   {% if products._in_query %} <a href ="https://www.google.com/">{{rendered_value}}</a>
#   {% else %}  <a href ="https://www.yahoo.com/">{{rendered_value}}</a>
#   {% endif %};;
  }

  # link: {
  #   label: "Show as Line Chart"
  #   url: "
  #   {% assign vis_config = '{
  #       \"stacking\"              : \"\",
  #       \"show_value_labels\"     : true,
  #       \"label_density\"         : 25,
  #       \"legend_position\"       : \"center\",
  #       \"x_axis_gridlines\"      : true,
  #       \"y_axis_gridlines\"      : true,
  #       \"show_view_names\"       : true,
  #       \"limit_displayed_rows\"  : false,
  #       \"y_axis_combined\"       : true,
  #       \"show_y_axis_labels\"    : false,
  #       \"show_y_axis_ticks\"     : true,
  #       \"y_axis_tick_density\"   : \"default\",
  #       \"y_axis_tick_density_custom\"   : 5,
  #       \"show_x_axis_label\"     : false,
  #       \"show_x_axis_ticks\"     : true,
  #       \"x_axis_scale\"          : \"auto\",
  #       \"show_null_points\"      : false,
  #       \"point_style\"           : \"none\",
  #       \"interpolation\"         : \"linear\",
  #       \"ordering\"              : \"none\",
  #       \"show_null_labels\"      : false,
  #       \"show_totals_labels\"    : false,
  #       \"show_silhouette\"       : false,
  #       \"type\"                  : \"looker_line\",
  #       \"totals_color\"          : \"#808080\",
  #       \"series_types\"          : {},
  #       \"x_axis_label\"          : \"Quarter\",
  #       \"series_colors\"         : {},
  #       \"series_labels\": {\"order_items.total_revenue\":\"Revenue\",\"order_items.total_profit\":\"Profit\"}

  #     }' %}
  #   {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"

  # }


#  https://localhost:9999/explore/leticia_model_exercise/order_items?qid=NKR2CxljzCBEYWMDgfkowA&toggle=dat,vis
  # html:
  # {% if products._in_query     %} <a href ="https://www.google.com/">{{rendered_value}}</a>
  # {% else %}  <a href ="https://www.yahoo.com/">{{rendered_value}}</a>
  # {% endif %};;


  # measure: total_profit_last_7_days {
  #   type: number
  #   sql: ${total_revenue}-${inventory_items.total_cost} ;;
  #   value_format_name: usd
  #   drill_fields: [orders.created_quarter, order_items.total_revenue, order_items.total_profit]
  #   filters: {
  #     field: orders.created_date
  #     value: "7 days ago for 7 days"
  #   }
  #   }

  # measure: total_profit_last_week {
  #   type: number
  #   sql: ${total_revenue}-${inventory_items.total_cost} ;;
  #   value_format_name: usd
  #   drill_fields: [orders.created_quarter, order_items.total_revenue, order_items.total_profit]
  #   filters: {
  #     field: orders.created_date
  #     value: "1 week ago"
  #   }
  # }


measure: profit_running_total {
  type: running_total
  sql: ${total_profit} ;;
}

measure: percent_of_total_profit {
  type: percent_of_total
  sql: ${total_profit};;
  value_format: "0.0\%"
}

filter: date_filter_test {
  description: "filter dates for offline"
  type: date_time
  suggest_explore: order_items
  suggest_dimension: orders.created_date
}

measure: date_test_measure {
  type: sum
  sql:
      CASE
      WHEN {% condition date_filter_test %} ${orders.created_date} {% endcondition %}
      THEN 1
      ELSE 0
    END
  ;;
}

filter: date_test_with_other_measure{
  type: string
}

measure: date_test_other_measure{
  type: number
  sql:
    CASE WHEN {% condition date_test_with_other_measure  %} ${orders.created_date} {% endcondition %}
    THEN ${total_revenue}-${inventory_items.total_cost}
    ELSE 0
    END
  ;;
}

# Test for autodesk





#   filter: date {
#     type: date
#     convert_tz: no
#   }
#
#   The measure will look like this:
#
#   measure: visitors_1_year_ago {
#     type: count_distinct
#     value_format: "#,##0"
#     sql: CASE WHEN ${universal_date_date}
#          BETWEEN dateadd(year, -1, {% date_start date %})
#          AND dateadd(year, -1, dateadd(day, -1, {% date_end date %}))
#           THEN ${visitor_id} END ;;
#     drill_fields: [visitor_drill*]}

# DATE_SUB(date, 1 MONTH)

  filter: date_filter_sub {
    type: date
  }

measure: date_test_subtract_time {
  type: sum
  sql:
      CASE WHEN
      ${orders.created_date} >= DATE_SUB( {% date_start date_filter_sub %} , INTERVAL 1 MONTH)
      AND ${orders.created_date} <= DATE_SUB( {% date_end date_filter_sub %} , INTERVAL 1 MONTH)
      THEN 1
      ELSE 0
      END
  ;;
}

filter: date_filter_test_pop {
  type: date
  sql: (${orders.created_date} >= DATE_SUB( {% date_start date_filter_test_pop %} , INTERVAL 1 YEAR)
  AND  ${orders.created_date} < DATE_SUB( {% date_end date_filter_test_pop %} , INTERVAL 1 YEAR))
  OR
  (${orders.created_date} >= {% date_start date_filter_test_pop %}  AND ${orders.created_date} < {% date_end date_filter_test_pop %})


  ;;

}



# dimension: date_test_subtract_time_date{
#     type: date
#     sql:
#       CASE WHEN
#       ${orders.created_date} >= DATE_SUB( {% date_start date_filter_sub %} , INTERVAL 1 MONTH)
#       AND ${orders.created_date} <= DATE_SUB( {% date_end date_filter_sub %} , INTERVAL 1 MONTH)
#       THEN ${orders.created_date}
#       ELSE 0
#       END
#   ;;
#   }


# Test End



# measure: profit_running_total_should_not_work{
#   type: running_total
#   sql:  ;;
# }

# measure: scatter_test {
#   type: number
#   sql: CONCAT(${total_revenue}," ",${total_profit}) ;;
# }


# dimension: test {
#  type:  number
# sql: CASE WHEN ${total_profit} >= 50 THEN 50
# ELSE ${total_profit} END;;
# }


#measure using sum - with profit field
measure: total_item_profit {
  type: sum
  sql: ${profit} ;;
  value_format_name: usd
#  drill_fields: [users.id, users.full_name, products.category,count]
  link: {
    label: "More information about this record"
    url: "https://localhost:9999/explore/leticia_model_exercise/order_items?fields=products.category,products.department,order_items.total_profit&f[products.category]={{ products.category._value | url_encode }}&f[products.department]={{ products.department._value | url_encode }}&f[orders.created_date]={{ _filters['orders.created_date'] | url_encode }}"
  }
#   html: <a href="https://www.google.com/">{{ value }}</a>  ;;
html: {% if value >= 50000 %}
      <p><font color="green">{{rendered_value}}</font></p>
      {% else %}
      <p><font color="red">{{rendered_value}}</font></p>
      {% endif %}
      ;;

}

#only apply formatting when the profit measure is in query
dimension: category_formatting_based_on_profit{
  type: string
  sql: ${products.category} ;;
  html:
        {% if order_items.total_item_profit._in_query and order_items.total_item_profit._value > 50000 %}
          <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% elsif order_items.total_item_profit._in_query and order_items.total_item_profit._value <= 50000 %}
          <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% else %}
          {{value}}
        {% endif %}
  ;;
}

measure: profit_range {
  label: "Range between Lowest and Highest Profit"
  description: "Evaluates the difference between lowest and highest profit"
  type: number
  sql: ${largest_item_profit}-${smallest_item_profit};;
  value_format_name: usd
  # value_format: "$0.000 \" k\";($0.000\" k\")"
  drill_fields: [users.id, users.full_name, products.category]

}


#dimension of type yesno
dimension: was_item_returned {
  label: "Was Item Returned?"
  type: yesno
  sql: ${returned_date} IS NOT NULL;;
# this will return red in red cell
#   html:
#   {% if value IS NOT NULL %}
#   <div style="background-color:#E33F0F">{{ value }}</div>
#   {% elsif value is null %}
#   <div style="background-color:#25A318">{{ value }}</div>
#   {% endif %}
#   ;;
}

dimension: yesno_reference_test{
  type: yesno
  sql: CASE WHEN ${was_item_returned} THEN 1
       ELSE 0
       END;;
}

measure: counts_filter {
  type: count
  filters: {
    field: was_item_returned
    value: "yes"
  }
}


  parameter: yesno_param {
    type: unquoted
    allowed_value: {
      label: "Yes"
      value: "1"
    }
    allowed_value: {
      label: "No"
      value: "0"
    }
    allowed_value: {
      label: "both"
      value: "1,0"
    }
  }

dimension: both_test {
  type: string
  sql:
      CASE WHEN ${was_item_returned}=1 THEN "yes"
      CASE WHEN ${was_item_returned}=0 THEN "no"
      ELSE "both"
      END

  ;;
}

dimension: both_yes_and_no {
  type: yesno
  sql:
      ${was_item_returned}=1 OR ${was_item_returned}=0
  ;;
}

#Liquid example coloring cells
dimension: returned_color{
  type: string
  sql: ${was_item_returned} ;;
  html:
        {% if value == 1 %}
          <div style="background-color:#E33F0F">{{ value }}</div>
        {% elsif value == 0 %}
          <div style="background-color:#25A318">{{ value }}</div>
        {% endif %}
  ;;
}

#This example masks the customer user ID if the Looker end-user is not allowed to see IDs.
#   dimension: safe_id {
#     sql:
#     CASE
#       WHEN '{{ _user_attributes['can_see_id'] }}' = 'Yes'
#       THEN ${id}::varchar
#       ELSE MD5(${id})
#     END
#   ;;
#   }


  filter: reconciled {
    type: yesno
    sql: ${returned_date} IS NULL ;;
# default_value: "No"
    view_label: "Sales Data"
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id]
  }

  measure: count_test {
    type: count
    drill_fields: [products.category, order_items.total_profit]

#     link: {
#       label: "Filtered Drill Modal"
#       url: "
#       {% assign vis_config = '{
#           \"show_view_names\":true,
#           \"show_row_numbers\":true,
#           \"truncate_column_names\":false,
#           \"hide_totals\":false,
#           \"hide_row_totals\":false,
#           \"table_theme\":\"editable\",
#           \"limit_displayed_rows\":false,
#           \"enable_conditional_formatting\":false,
#           \"conditional_formatting_include_totals\":false,
#           \"conditional_formatting_include_nulls\":false,
#           \"type\":\"table\",
#           \"stacking\":\"\",
#           \"show_value_labels\":false,
#           \"label_density\":25,
#           \"legend_position\":\"center\",
#           \"x_axis_gridlines\":false,
#           \"y_axis_gridlines\":true,
#           \"y_axis_combined\":true,
#           \"show_y_axis_labels\":true,
#           \"show_y_axis_ticks\":true,
#           \"y_axis_tick_density\":\"default\",
#           \"y_axis_tick_density_custom\":5,
#           \"show_x_axis_label\":true,
#           \"show_x_axis_ticks\":true,
#           \"x_axis_scale\":\"auto\",
#           \"y_axis_scale_mode\":\"linear\",
#           \"x_axis_reversed\":false,
#           \"y_axis_reversed\":false,
#           \"ordering\":\"none\",
#           \"show_null_labels\":false,
#           \"show_totals_labels\":false,
#           \"show_silhouette\":false,
#           \"totals_color\":\"#808080\",
#           \"series_types\":{}
#
#       }' %}
#       {{ link }}&f[order_items.total_profit]=>50000&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
#
#     }

    link: {
      label: "Filtered Drill Modal"
      url: "{{ link }}&f[order_items.total_profit]=>=50000"
    }

    #html: <a href="{{ link }}&f[order_items.total_profit]=>=50000">{{ rendered_value }}</a> ;;


  }


   parameter: metric_selector {
     type: string
     allowed_value: {
       label: "Total Order Profit"
       value: "total_profit"
     }
     allowed_value: {
       label: "Total Revenue"
       value: "total_revenue"
     }
   }
   measure: metric {
     label_from_parameter: metric_selector
     type: number
     value_format: "$0.0,\"K\""
     sql:
       CASE
         WHEN {% parameter metric_selector %} = 'total_profit' THEN
           ${total_profit}
         WHEN {% parameter metric_selector %} = 'total_first_purchase_revenue' THEN
           ${total_revenue}

         ELSE
           NULL
       END ;;
   }

# filter: date_test {
#   type: date
# }
#
# measure: test_thing {
#   type: number
#   sql:
#       CASE
#          WHEN EXTRACT(MONTH from DATE_SUB({% parameter date_test %}, INTERVAL -1 MONTH)) = EXTRACT(MONTH from ${returned_time}) THEN
#            ${total_profit}
#
#          ELSE
#            NULL
#       END
#   ;;
# }



  parameter: fieldname {
    type: unquoted
  }

  dimension: thing {
    type: string
    sql: ${TABLE}.{% parameter fieldname %} ;;
    }

  measure: count_distinct_vis_test {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [orders.created_date, order_items.total_sale_price]
    link: {
      label: "Show as line plot"
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
      \"point_style\"               : \"none\",
      \"ordering\"                  : \"none\",
      \"show_null_labels\"          : false,
      \"show_totals_labels\"        : false,
      \"show_silhouette\"           : false,
      \"totals_color\"              : \"#808080\",
      \"type\"                      : \"looker_area\",
      \"interpolation\"             : \"linear\",
      \"series_types\"              : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\"             : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\"             : \"#38A6A5\",
      \"label_position\"    : \"left\",
      \"period\"            : 30,
      \"regression_type\"   : \"average\",
      \"series_index\"      : 1,
      \"show_label\"        : true,
      \"label_type\"        : \"string\",
      \"label\"             : \"30 day moving average\"
      },
      {
      \"color\"             : \"#EDAD08\",
      \"label_position\"    : \"right\",
      \"period\"            : 7,
      \"regression_type\"   : \"average\",
      \"series_index\"      : 1,
      \"show_label\"        : true,
      \"label_type\"        : \"string\",
      \"label\"             : \"7 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  dimension: case_category{
    type: string
    sql: CASE WHEN ${products.category} IN ("Pants","Shorts") AND ${order_items.sale_price} > 50 THEN "Win"
          ELSE "other"
          END;;
  }

#DYNAMICALLY FILTER A DASHBOARD WITH OR LOGIC

filter: category_filter{
  type: string
  suggest_dimension: products.category
}

filter: department_filter{
  type: string
  suggest_dimension: products.department
}

dimension: dashboard_category_department{
  type: yesno
  sql:
      ({% condition category_filter %} ${products.category} {% endcondition %} OR
       {% condition department_filter %} ${products.department} {% endcondition %}) ;;
}


#more templated filters tests
dimension: one_filter_for_two_fields {
  type: yesno
  sql: ({% condition category_filter %} products.category {% endcondition %} AND
        {% condition category_filter %} products.department {% endcondition %}) ;;
}

#Updating two fields with one filter
filter: date_for_two_date_fields {
  type: date_time
}

dimension: yesno_two_date_fields {
  type: yesno
  sql: ({% condition date_for_two_date_fields %} ${order_items.returned_date} {% endcondition %} AND
        {% condition date_for_two_date_fields %} ${orders.created_date} {% endcondition %}) ;;
}


#templated filters test
## filter determining time range for all "A" measures

  filter: timeframe_a {
    type: date
  }

## flag for "A" measures to only include appropriate time range

  dimension: group_a_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_a %} ${orders.created_date} {% endcondition %} ;;
  }

## filtered measure A

  measure: count_a {
    type: count
    filters: {
      field: group_a_yesno
      value: "yes"
    }
  }

## filter determining time range for all "B" measures

  filter: timeframe_b {
    type: date
  }

## flag for "B" measures to only include appropriate time range

  dimension: group_b_yesno {
    hidden: yes
    type: yesno
    sql: {% condition timeframe_b %} ${orders.created_date} {% endcondition %} ;;
  }

  measure: count_b {
    type: count
    filters: {
      field: group_b_yesno
      value: "yes"
    }
  }

  measure: count_pants {
    type: count
    filters: {
      field: products.category
      value: "pants"
    }
  }


measure: count_active_women {
  type: count
  filters: {
    field: products.category
    value: "active"
  }
  filters: {
    field: products.department
    value: "women"
  }
}

  filter: category_filter_funnel {
    type: string
    suggest_dimension: products.category
  }

  dimension: funnel_yesno {
    type: yesno
    sql: {% condition category_filter_funnel %} ${products.category} {% endcondition %}
         OR ${products.category} IS NULL;;
  }


set: exclude_test {
  fields: [
    order_items.order_id,
    order_items.user_id
  ]
}

set: exclude_test_2 {
  fields: [
    -order_items.order_id,
    -order_items.user_id
  ]
}

dimension: test_date_range {
  type: yesno
  sql:
       CASE WHEN DAYNAME(CURTIME()) IN("Monday", "Tuesday", "Wednesday") THEN
       (${orders.created_date}  < (DATE_ADD(TIMESTAMP(DATE(DATE_ADD(DATE(NOW()),INTERVAL (0 - MOD((DAYOFWEEK(DATE(NOW())) - 1) - 1 + 7, 7)) day))),INTERVAL 0 week)))
       WHEN DAYNAME(CURTIME()) IN("Thursday", "Friday", "Saturday", "Sunday") THEN
       (${orders.created_date}  < (DATE_ADD(TIMESTAMP(DATE(DATE_ADD(DATE(NOW()),INTERVAL (0 - MOD((DAYOFWEEK(DATE(NOW())) - 1) - 1 + 7, 7)) day))),INTERVAL -1 week)))
  ELSE null
  END
  ;;
}

#Example when helping AK

parameter: category_parameter {
  type: string
  suggest_dimension: products.category
}

parameter: category_unquoted {
  type: string
}

dimension: param_curl_test {
  sql: {% parameter category_unquoted %} ;;
}

dimension: parameter_condition {
  type: string
  sql:
      {% if category_unquoted._parameter_value == 'jeans' or category_unquoted._parameter_value == 'Jeans' %}
        "yes"
      {% else %}
        "no"
      {% endif %}
  ;;
}

#       {% if category_parameter._parameter_value == "'Jeans'" %}
# or category_unquoted._parameter_value == 'Jeans'
# order_items.category_parameter._in_query
#End of example for AK

dimension: department_ca_yn {
  type: yesno
  sql: ${users.is_california}=1 AND (${products.department}="Men" OR ${products.department}="Women");;
}


  parameter: item_to_add_up {
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "sale_price"
    }
    allowed_value: {
      label: "Total Cost"
      value: "cost"
    }
    allowed_value: {
      label: "Total Profit"
      value: "profit"
    }
  }

filter: one_more_month_filter {
  type: date
  sql: ${orders.created_raw} >= DATE_SUB({% date_start one_more_month_filter %}, INTERVAL 1 MONTH) AND ${orders.created_raw} < {% date_end one_more_month_filter %} ;;
}

  filter: category_adina {
    type: string
    suggest_dimension: products.category
    sql: {% condition category_adina %} products.category {% endcondition %};;
  }


measure: total_profit_emoji {
    type: number
    sql: ${total_revenue}-${inventory_items.total_cost} ;;
    value_format_name: usd
    html: {% if value >= 75000 %}
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
          {% elsif value >= 50000 and value < 75000 %}
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
          {% else %}
            <img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/129/white-medium-star_2b50.png" style="width:25px;height:25px;"/>
          {% endif %}
    ;;
  }

  measure: total_profit_emoji_2 {
    type: number
    sql: ${total_revenue}-${inventory_items.total_cost} ;;
    value_format_name: usd
    html: {% if value >= 75000 %}
            ⭐️⭐️⭐️⭐️⭐️
          {% elsif value >= 50000 and value < 75000 %}
            ⭐️⭐️⭐️
          {% else %}
            ⭐️
          {% endif %}
    ;;
  }


  filter: date_1_lauren {
    type: date
  }

  filter: date_2_lauren {
    type: number
  }

  dimension: dates_dimension_lauren {
    type: yesno
    sql:
        {% condition date_1_lauren %} ${orders.created_date} {% endcondition %}
        AND
        {% condition date_2_lauren %} ${order_items.sale_price} {% endcondition %}
    ;;
  }


 }
