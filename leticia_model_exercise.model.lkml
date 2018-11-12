connection: "thelook"

# include all the views
include: "*.view"

# model for ramp lookml project
# include all the dashboards
  include: "*.dashboard"
  include: "Misc/*"

datagroup: 24_hour_caching {
  max_cache_age: "24 hours"
}



explore: conditionally_filter {}
explore: boolean_test {}
explore: linked_derived_table_test {}
explore: list_test_ndt {}
explore: ndt_dim_group_test{}
explore: ndt_min_date {}
explore: sql_runner_query {}
explore: filter_options_test {}
explore: ndt_chat_test {}
explore: pdt_lab_1_orders {
  label: "PDT LAB 1"
  join: pdt_lab_1_b {
    type: left_outer
    sql_on: ${pdt_lab_1_orders.id}=${pdt_lab_1_b.id} ;;
    relationship: many_to_one
  }
}
explore: pdt_lab_1_b {}
explore: lab_1_derived_table {}

explore: name_attributes_test {
  # sql_always_where: ${last_name} =
  #                   {% if _user_attributes['last_name'] == "Scott" %}
  #                   "Scott"
  #                   {% else %}
  #                   ${last_name}
  #                   {% endif %}
  # ;;
}


#Explore with fields parameter
explore: events {
  extension: required
  join: users {
#    fields: [users.full_name]
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
explore: test_format {}

explore: inventory_items {
#   extension: required
#   view_name: inventory_items
#   from: inventory_items
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

#join used for profit dimension in order_items
explore: order_items {
#  persist_with: 24_hour_caching
#   always_filter: {
#     filters: {
#       field: products.category
#       value: "%pant%,%act%"
#     }
#   }
  join: inventory_items {
    #fields: []
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    #view_label: "User Orders"
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }
## Joining PDT
  join: user_facts {
    type: left_outer
    sql_on: ${orders.user_id} = ${user_facts.user_id} ;;
    relationship: many_to_one
  }
#   join: user_facts_test {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${user_facts_test.user_id} ;;
#     relationship: many_to_one
#   }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id};;
    relationship: many_to_one
  }

#   join: disc_test_pdt {
#     type: left_outer
#     sql_on: ${disc_test_pdt.id} = ${products.id};;
#     relationship: many_to_one
#   }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

}


#Explore with always_filter parameter; Looks at the orders from users only in California
explore: orders {
#   always_filter: {
#     filters: {
#     field: users.state
#     value: "California"
#
#     }
#
#   }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

}

explore: products {
#  fields: [ALL_FIELDS*, -products.exclude_test*]
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# view: list_ndt {
#   derived_table: {
#     explore_source: products{
#       column: id {field: products.id}
#       column: category {field: products.category}
#       column: list_test {field: products.list_test}
#     }
#   }
#   dimension: id {hidden: no primary_key:yes}
#   dimension: category {type:string}
#   measure: list_test {type:list
#                       list_field:category}
# }

# explore: list_ndt {}

# beginning of ndt test
view: ndt1 {
  derived_table: {
    explore_source: orders {
      column: user_id {field: orders.user_id}
      column: number_of_orders {field: orders.count}
    }
#     persist_for: "4 hours"
#     indexes: ["user_id"]
  }
  # Define the view's fields as desired
  dimension: user_id {hidden: no
    primary_key:yes}
  dimension: number_of_orders {type: number}
}

view: ndt2 {
  derived_table: {
    explore_source: orders {
      column: user_id {field: orders.user_id}
      column: first_order {field: orders.first_order}
      column: last_order {field: orders.last_order}
    }
  }
  # Define the view's fields as desired
  dimension: user_id {hidden: no
    primary_key:yes}
  measure: first_order {type: date}
  measure: last_order {type: date}
}

explore: ndt1 {
  join: ndt2 {
    type: left_outer
    sql_on: ${ndt1.user_id}=${ndt2.user_id} ;;
    relationship: many_to_one
  }
}

explore: extend_my_pdt_test {}
datagroup: pdt_test_datagroup {
  sql_trigger: SELECT max(id) FROM products ;;
  max_cache_age: "24 hours"
}
#end of ndt test

explore: stn_test {}
explore: users {}

explore: users_nn {}

explore: user_facts_test {}
explore: users_nested {}

explore: user_facts {}
explore: pdt_test {}
explore: running_total_test {}

explore: monthly_active_users {}

# explore: second_most_recent_date {}

explore: MAU_test {
  view_name: user_facts
  join: second_most_recent_date {
    type: left_outer
    sql_on: ${second_most_recent_date.user_id}=${user_facts.user_id} ;;
    relationship: many_to_one
  }
  }

  explore: p_test {
    view_name: products

  }


# map_layer: my_neighborhood_layer {
#   file: "POLYGON.topojson"
#   property_key: "test_ca"
# }

  explore: long_string_table {}
explore: table_calc_test_table {}
explore: the_test {}
#   explore: second_most_recent_date {
#     join: user_facts {
#       type: left_outer
#       sql: ${user_facts.user_id}=${second_most_recent_date.user_id} ;;
#       relationship: many_to_one
#     }
#
# }
