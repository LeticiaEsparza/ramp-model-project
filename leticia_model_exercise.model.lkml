connection: "thelook"

# include all the views
include: "*.view"

# model for ramp lookml project
# include all the dashboards
include: "*.dashboard"

#Explore with fields parameter
explore: events {
  join: users {
    fields: [users.full_name]
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

#join used for profit dimension in order_items
explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    view_label: "User Orders"
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
  join: user_facts_test {
    type: left_outer
    sql_on: ${orders.user_id} = ${user_facts_test.user_id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id};;
    relationship: many_to_one
  }

  join: disc_test_pdt {
    type: left_outer
    sql_on: ${disc_test_pdt.id} = ${inventory_items.product_id};;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

}


#Explore with always_filter parameter; Looks at the orders from users only in California
explore: orders {
  always_filter: {
    filters: {
    field: users.state
    value: "California"

    }

  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

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

datagroup: pdt_test_datagroup {
  sql_trigger: SELECT max(id) FROM products ;;
  max_cache_age: "24 hours"
}
#end of ndt test

explore: users {}
explore: counts_tester {}

explore: users_nn {}
explore: user_facts_test {}
explore: user_facts {}
explore: pdt_test {}
