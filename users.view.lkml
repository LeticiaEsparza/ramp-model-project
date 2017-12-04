view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
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


dimension: relative_year {
  case: {
        when: {
          sql: ${created_year} = '2017'  ;;
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

}




  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
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

# Dimension with zip code
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
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



}
