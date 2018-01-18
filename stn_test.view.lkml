view: stn_test {

sql_table_name: ( SELECT * FROM demo_db.order_items WHERE ${returned_date} IS NULL);;
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

}
