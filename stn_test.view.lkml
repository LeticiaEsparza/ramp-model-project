view: stn_test {

sql_table_name: (SELECT * FROM order_items  WHERE returned_at IS NULL) ;;

}
