view: user_facts_test {

  derived_table: {
    sql: SELECT
           orders.user_id AS user_id,
           COUNT(DISTINCT orders.id) AS total_orders,
           MIN(NULLIF(orders.created_at,0)) as first_order,
           MAX(NULLIF(orders.created_at,0)) as latest_order,
           CASE WHEN COUNT(orders.created_at)>1 THEN 'yes' ELSE 'no' END AS repeat_customer,
           DATEDIFF(CURDATE(), MIN(NULLIF(orders.created_at,0))) AS days_since_first_purchase
           FROM order_items JOIN orders ON order_items.order_id=orders.id
           GROUP BY orders.user_id
           ORDER BY COUNT(DISTINCT orders.id) desc




 ;;
    sql_trigger_value: SELECT current_date;;
    indexes: ["user_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: total_orders {
    type: string
    sql: ${TABLE}.total_orders ;;
  }

  dimension: first_order {
    type: string
    sql: ${TABLE}.first_order ;;
  }

  dimension: latest_order {
    type: string
    sql: ${TABLE}.latest_order ;;
  }

  dimension: repeat_customer {
    type: string
    sql: ${TABLE}.repeat_customer ;;
  }

#   dimension: avg_orders_per_month {
#     type: string
#     sql: ${TABLE}.avg_orders_per_month ;;
#   }

  dimension: days_since_first_purchase {
    type: string
    sql: ${TABLE}.days_since_first_purchase ;;
  }

  set: detail {
    fields: [
      user_id,
      total_orders,
      first_order,
      latest_order,
      repeat_customer,
      days_since_first_purchase
    ]
  }

}

view: users_nested {
  sql_table_name: demo_db.users ;;

  dimension: id {
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

  dimension: is_female {
    type: yesno
    sql: ${gender}='f' ;;
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
}
