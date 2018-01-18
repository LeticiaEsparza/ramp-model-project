view: stn_test {

sql_table_name: demo_db.order_items ;;
  dimension: id {
    primary_key: yes
    #hidden: yes
    type: number
    sql: ${TABLE}.id ;;
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









  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }

}
