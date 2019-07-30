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
    html: <a href="/explore/leticia_model_exercise/order_items?fields=products.brand,orders.count,order_items.total_revenue,order_items.total_profit,users.count&f[products.brand]={{ filterable_value }}">{{ value }}</a> ;;
  }

  dimension: category {
    type: string
    #hidden: yes
    sql: ${TABLE}.category ;;
  #  drill_fields: [id, item_name]
    #EXAMPLES FOR URL ENCODE LESSON
    # html:  <a href="/dashboards/43?Category={{ value | url_encode }}&Brand={{ _filters['products.brand'] | url_encode }}">{{ value }}</a> ;;
    link: {
      label: "Category & Brand Info"
      url: "/dashboards/43?Category={{ value | url_encode }}&Brand={{ _filters['products.brand'] | url_encode }}"
    }
    #EXAMPLE FOR INTRO
    #html:  <a href="https://www.google.com/">{{ value }}</a> ;;
    #html:  <a href="https://www.google.com/search?q={{value}}">{{ value }}</a> ;;
    # link: {
    #   label: "Google Search"
    #   url: "https://www.google.com/search?q={{value}}"
    #   icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
    # }
  }

  dimension: category_url {
    type: string
    sql: "Dashboard URL" ;;
    link: {
      label: "/dashboards/43?Brand={{ _filters['products.brand'] | url_encode }}"
      url: "/dashboards/43?Brand={{ _filters['products.brand'] | url_encode }}"
    }
  }


  dimension: category_suggestions {
    type: string
    sql: ${category} ;;
    suggestions: ["Clothing Sets","Fashion Hoodies & Sweatshirts","Suits & Sport Coats","Socks & Hosiery"]
  }

#PARAMETERS EXAMPLE WITH A DIMENSION OF TYPE STRING
  parameter: category_limited_values {
    type: string
    allowed_value: { value: "Clothing Sets" }
    allowed_value: { value: "Fashion Hoodies & Sweatshirts" }
    allowed_value: { value: "Suits & Sport Coats" }
    allowed_value: { value: "Socks & Hosiery" }
  }
#WE CAN INCLUDE THE NORMAL CATEGORY DIMENSION AND FILTER BY THIS DIMENSION BEING 1 (TRUE)
dimension: category_limited_value_dimension {
  label_from_parameter: category_limited_values
  sql:
      CASE WHEN {% parameter category_limited_values %} = 'Clothing Sets' THEN ${category} = 'Clothing Sets'
           WHEN {% parameter category_limited_values %} = 'Fashion Hoodies & Sweatshirts' THEN ${category} = 'Fashion Hoodies & Sweatshirts'
           WHEN {% parameter category_limited_values %} = 'Suits & Sport Coats' THEN ${category} = 'Suits & Sport Coats'
           WHEN {% parameter category_limited_values %} = 'Socks & Hosiery' THEN ${category} = 'Socks & Hosiery'
      ELSE ${category}
      END
  ;;
}
#END OF EXAMPLE

dimension: colorful_image {
  type: string
  sql: ${category} ;;
  html: <img src="https://scontent-sea1-1.xx.fbcdn.net/v/t1.0-9/65439723_10157424671227958_2274128794606370816_o.png?_nc_cat=101&_nc_oc=AQmO5ltZeqaiRGzp1n6SrYABXZdOds3ErgTzTdz04mt1eafQnTcHoEnMbgB6s7EpbTQ&_nc_ht=scontent-sea1-1.xx&oh=177888101b45735d36dd12d414082aa4&oe=5DB2C995" width="50%" height="30%"/> ;;
  }


  dimension: category_case_when {
    case: {
      when: {
        sql: ${category}="Clothing Sets" ;;
        label: "Clothing Sets"
      }
      when: {
        sql: ${category}="Fashion Hoodies & Sweatshirts" ;;
        label: "Fashion Hoodies & Sweatshirts"
      }
      when: {
        sql: ${category}="Suits & Sport Coats" ;;
        label: "Suits & Sport Coats"
      }
      when: {
        sql: ${category}="Socks & Hosiery" ;;
        label: "Socks & Hosiery"
      }
      when: {
        sql: ${category}="Jumpsuits & Rompers" ;;
        label: "Jumpsuits & Rompers"
      }
      when: {
        sql: ${category}="Sleep & Lounge" ;;
        label: "Sleep & Lounges"
      }
      when: {
        sql: ${category}="Outerwear & Coats" ;;
        label: "Outerwear & Coats"
      }
      when: {
        sql: ${category}="Blazers & Jackets" ;;
        label: "Blazers & Jackets"
      }
      when: {
        sql: ${category}="Pants & Capris" ;;
        label: "Pants & Capris"
      }
      when: {
        sql: ${category}="Underwear" ;;
        label: "Underwear"
      }
      when: {
        sql: ${category}="Tops & Tees" ;;
        label: "Tops & Tees"
      }
      when: {
        sql: ${category}="Accessories" ;;
        label: "Accessories"
      }
      when: {
        sql: ${category}="Intimates" ;;
        label: "Intimates"
      }
      when: {
        sql: ${category}="Maternity" ;;
        label: "Maternity"
      }
      when: {
        sql: ${category}="Leggings" ;;
        label: "Leggings"
      }
      when: {
        sql: ${category}="Shorts" ;;
        label: "Shorts"
      }
      when: {
        sql: ${category}="Active" ;;
        label: "Active"
      }
      when: {
        sql: ${category}="Skirts" ;;
        label: "Skirts"
      }
      when: {
        sql: ${category}="Socks" ;;
        label: "Socks"
      }
      when: {
        sql: ${category}="Pants" ;;
        label: "Pants"
      }
      when: {
        sql: ${category}="Plus" ;;
        label: "Plus"
      }
      when: {
        sql: ${category}="Suits" ;;
        label: "Suits"
      }
      when: {
        sql: ${category}="Swim" ;;
        label: "Swim"
      }
      else: "empty"
    }
  }

  dimension: category_ryland_1 {
    type: string
    sql:
        CASE WHEN ${category}="Accessories" THEN "Bling"
        ELSE "Other"
        END
    ;;
  }

  dimension: category_ryland_2 {
    case: {
      when: {
        sql: ${category}="Accessories" ;;
        label: "Bling"
      }
      else: "Other"
    }
  }

  parameter: category_parameter {
    type: string
    suggest_dimension: products.category
  }


dimension: category_example {
  type: string
  sql: ${TABLE}.category ;;
#  html: <b><center><p style="background-color:#B3F5F7;"><font size="4" color="#166088">{{value}}</font></p></center></b>;;
  html: <p style="color: #166088; background-color: #B3F5F7; font-size: 200%; text-align:center">{{value}}</p> ;;
#   html:
#         {% if _user_attributes['company'] == "Looker" %}
#           <p style="color: #5A2FC2; background-color: #E5E5E6; font-size: 180%; font-weight: bold; text-align:center">{{value}}</p>
#         {% else %}
#           <p style="color: #166088; background-color: #B3F5F7; font-size: 180%; font-weight: bold; text-align:center">{{value}}</p>
#         {% endif %}
#   ;;
}

  dimension: category_example_2 {
    type: string
    sql: ${TABLE}.category ;;
    html: <b><center><p style="background-color:#B3F5F7;"><a href="/dashboards/40?Category={{ value | url_encode }}"><font size="4" color="#166088">{{value}}</font></a></p></center></b>;;

    #html: <p style="color: #166088; background-color: #B3F5F7; font-size: 200%; text-align:center">{{value}}</p> ;;
  }

# dimension: case_category{
#   type: string
#   sql: CASE WHEN ${products.category} IN ("Pants","Shorts") AND ${order_items.sale_price} > 50 THEN "Win"
#   ELSE "other"
#   END;;
# }

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
  html: <b>{{rendered_value}}</b> ;;
}


  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: department_center{
    type: string
    sql: ${department} ;;
    # html: <center>{{rendered_value}}</center> ;;
    drill_fields: [id, brand]
  }


  dimension: dummy_three {
    case: {
      when: {
        label: "Men"
        sql: 1=1 ;;
      }
      when: {
        label: "Women"
        sql: 1=1 ;;
      }

    }}

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

    dimension: category_colors {
    type: string
    sql: ${category}  ;;
    html:
    {% if value == "Accessories" %}
    <center><b><div style="background-color:#00E400">{{ rendered_value }}</div></b></center>
    {% elsif value == "Active"  %}
    <center><b><div style="background-color:#FFFF00">{{ rendered_value }}</div></b></center>
    {% elsif value == "Blazers & Jackets" %}
    <center><b><div style="background-color:#FF7E00"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% elsif value == "Clothing Sets"  %}
    <center><b><div style="background-color:#FF0000"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% elsif value == "Dresses"  %}
    <center><b><div style="background-color:#8F3F97"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% else %}
    <center><b><div style="background-color:#7E0023"><font color="white">{{ rendered_value }}</font></div></b></center>
    {% endif %}
    ;;
  }

  filter: category_for_filtered_count {
    type: string
    suggest_dimension: products.category
  }

  dimension: category_yesno {
    hidden: yes
    sql: {% condition category_for_filtered_count %} products.category {% endcondition %};;
  }

    measure: count_category {
      type: count
      filters: {
        field: category_yesno
        value: "yes"
      }

    }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
  set: exclude_test {
    fields: [
      category,
      brand
    ]
  }
}
