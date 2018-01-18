view: stn_test {

sql_table_name: (SELECT * FROM order_items  WHERE order_items.returned_at IS NULL) ;;

}
