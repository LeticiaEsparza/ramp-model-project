view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    tags: ["id"]
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # dimension: html_user_id_test {
  #   type: number
  #   sql: ${id} ;;
  #   html: {{ users.email._value }} ;;
  # }

  dimension: test_key_value_1 {
    type: string
    sql: CONCAT(${email}, " <id ", ${id}, ">") ;;
  }
  parameter: test_parameter{
    suggest_dimension: test_key_value_1
  }

  dimension: result_of_parameter {
    type: number
    sql: SUBSTRING({% parameter test_parameter %}, -5, 4);;
    value_format_name: id
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
#     map_layer_name: city
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }



#case when test dimension ticket #113557
dimension: relative_year {
  case: {
        when: {
          sql: ${created_year} = '2017' ;;
          label: "current"
        }
        when: {
          sql: ${created_year} = '2016' ;;
          label: "last year"
        }
        when: {
          sql: ${created_year} = '2015' ;;
          label: "about two years ago"
        }
        when: {
          sql: ${created_year} = '2014' ;;
          label: "about three years ago"
        }

  }
  #alpha_sort: yes
}






  dimension: email {
    tags: ["email"]
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    tags: ["first_name"]
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: is_female {
    type: yesno
    sql: ${gender}='f' ;;
  }

  dimension: is_female_test {
    type: string
    sql: CASE WHEN ${is_female} THEN "female"
         ELSE ""
         END
        ;;
  }

  dimension: last_name {
    tags: ["last_name"]
    type: string
    sql: ${TABLE}.last_name ;;
  }

#Dimension of type string
  dimension: full_name {
    type: string
    sql: CONCAT(${TABLE}.first_name,' ',${TABLE}.last_name);;
    }


  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: is_california {
    type: yesno
    sql: ${state}='California' ;;
  }
  dimension: is_female_california{
    type: yesno
    sql: ${is_female}=1 AND ${is_california}=1;;
  }



# Dimension with zip code
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
    map_layer_name: us_zipcode_tabulation_areas
  }

  dimension: zip_b {
    type: number
    sql: ${TABLE}.zip ;;
    value_format: "0####"
  }

#Dimension of type location
dimension: users_location {
  type: location
  sql_latitude: ${TABLE}.latitude;;
  sql_longitude: ${TABLE}.longitude ;;

}

# filtered measure how many users are from California
measure: users_in_ca {
  type: count_distinct
  sql: ${TABLE}.id ;;
  filters: {
    field: state
    value: "California"
  }
}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }

  measure: user_count_test {
    label: "repro pivot measure with coalesce"
    type: count_distinct
    sql: COALESCE(${id}, ${full_name});;
  }

}
