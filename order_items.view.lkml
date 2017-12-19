view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
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
  drill_fields: [users.id, users.full_name, products.category]

}


#measure using sum - with profit field
measure: total_item_profit {
  type: sum
  sql: ${profit} ;;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

}

measure: profit_range {
  label: "Range between Lowest and Highest Profit"
  description: "Evaluates the difference between lowest and highest profit"
  type: number
  sql: ${largest_item_profit}-${smallest_item_profit};;
  value_format_name: usd
  drill_fields: [users.id, users.full_name, products.category]

}


#dimension of type yesno
dimension: was_item_returned {
  label: "Was Item Returned?"
  type: yesno
  sql: ${returned_date} IS NOT NULL ;;

}


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






}
