view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    #hidden: yes
    sql: ${TABLE}.category ;;
    drill_fields: [id, item_name]
  }

dimension: category_dupe_test{
  label: "Category Dupe"
  type: string
  sql: ${category} ;;
}


# dimension: case_when_test {
#   type: string
#   sql: ${category} WHERE ${category} LIKE "s%" ;;
# }
#   dimension: category_colors {
#     type: string
#     sql: ${category}  ;;
#     html:
#     {% if value == "Accessories" %}
#     <center><b><div style="background-color:#00E400">{{ rendered_value }}</div></b></center>
#     {% elsif value == "Active"  %}
#     <center><b><div style="background-color:#FFFF00">{{ rendered_value }}</div></b></center>
#     {% elsif value == "Blazers & Jackets" %}
#     <center><b><div style="background-color:#FF7E00"><font color="white">{{ rendered_value }}</font></div></b></center>
#     {% elsif value == "Clothing Sets"  %}
#     <center><b><div style="background-color:#FF0000"><font color="white">{{ rendered_value }}</font></div></b></center>
#     {% elsif value == "Dresses"  %}
#     <center><b><div style="background-color:#8F3F97"><font color="white">{{ rendered_value }}</font></div></b></center>
#     {% else %}
#     <center><b><div style="background-color:#7E0023"><font color="white">{{ rendered_value }}</font></div></b></center>
#     {% endif %}
#     ;;
#   }

  dimension: test_case {
    type: number
    sql:  CASE WHEN ${category} LIKE "a%" THEN 1
              WHEN ${category} LIKE "b%" THEN 2
          ELSE null
          END;;
  }



#LIQUID IN URLS

 dimension: category_google_search{
  type: string
  sql: ${category} ;;
  link: {
    label: "Category Google Search Test"
    url: "https://www.google.com/search?q={{ value }}"
  }
 }


# filter: date_filter_test {
#   type: string
# }
#
# dimension: date_test_dimension {
#   type: yesno
#   hidden: yes
#   sql: {% condition date_filter_test %} ${orders.created_date} {% endcondition %} ;;
# }
#
# measure: count_category_within_date{
#   type: count
#   filters: {
#     field: date_test_dimension
#     value: "yes"
#   }
# }






#FILTER MEASURE BY DATES


# measure: count_pants {
#   type: count
#   filters: {
#     field: category
#     value: "Pants"
#   }
#   filters: {
#     field: orders.created_date
#     value: "2018/01/10 for 10 days"
#   }
# }
#
#
# measure: count_pants_2 {
#   type: count
#   filters: {
#     field: category
#     value: "Pants"
#   }
#   filters: {
#     field:orders.created_date
#     value: "2018/02/01 for 10 days"
#   }
#
# }
#   view: view_name {
#     measure: field_name {
#       filters: {
#         field: dimension_name
#         value: "looker filter expression"
#       }
#       # Possibly more filter statements
#     }
#   }

measure: list_category{
  type: list
  list_field: category
}


  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
