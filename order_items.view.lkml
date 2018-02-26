view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    #hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

# dimension: test_hard_insert {
#   type: date
#   sql: CURDATE();;
#
# }

# filter: test_filter_2 {
#   sql: {% condition %} ${products.test_filter} {% endcondition %} ;;
# }

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

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
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

#measure using sum
measure: total_revenue {
  type: sum
  sql: ${sale_price};;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

}

#measure using multiple measures - I basically created this to
#verify that the total item profit was revealing the same results
measure: total_profit {
  label: "Total Profit"
  type: number
  sql: ${total_revenue}-${inventory_items.total_cost} ;;
  value_format_name: usd
#   drill_fields: [users.id, users.full_name, products.category]
  html:
  {% if products._in_query     %} <a href ="https://www.google.com/">{{rendered_value}}</a>
  {% else %}  <a href ="https://www.yahoo.com/">{{rendered_value}}</a>
  {% endif %};;

}

measure: profit_running_total {
  type: running_total
  sql: ${total_profit} ;;
}


filter: date_filter_test {
  description: "filter dates for offline"
  type: string
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
  #drill_fields: [users.id, users.full_name, products.category,count]
  html: <a href="https://www.google.com/">{{ value }}</a>  ;;

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

# parameter: liquid_test {
#   type: string
#   allowed_value: {{ products.category }} ;;
# }
#
# dimension: liquid_filter_test {
#   label_from_parameter: liquid_test
#
# }



  filter: reconciled {
    type: yesno
    sql: ${returned_date} IS NULL ;;
# default_value: "No"
    view_label: "Sales Data"
  }

#   filter: wir {
#     type: yesno
#     sql: ${returned_date} IS NOT NULL ;;
# # default_value: "No"
#     view_label: "Sales Data"
#   }


  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
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



}
