view: stn_test {

sql_table_name: ( SELECT * FROM demo_db.order_items WHERE demo_db.order_items.returned_at IS NULL) ;;

}
