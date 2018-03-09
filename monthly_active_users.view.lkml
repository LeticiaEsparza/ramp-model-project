view: monthly_active_users {
    derived_table: {
      sql:
         (SELECT 1 as ID, DATE("2017-06-15") as month_check, "Y" as active, 4 as number_of_rides) UNION ALL
         (SELECT 1 as ID, DATE("2017-07-15") as month_check, "Y" as active, 3 as number_of_rides) UNION ALL
         (SELECT 1 as ID, DATE("2017-08-15") as month_check, "N" as active, 1 as number_of_rides) UNION ALL
         (SELECT 1 as ID, DATE("2017-09-15") as month_check, "N" as active, 0 as number_of_rides) UNION ALL
         (SELECT 2 as ID, DATE("2017-06-15") as month_check, "N" as active, 0 as number_of_rides) UNION ALL
         (SELECT 2 as ID, DATE("2017-07-15") as month_check, "Y" as active, 8 as number_of_rides) UNION ALL
         (SELECT 2 as ID, DATE("2017-08-15") as month_check, "Y" as active, 9 as number_of_rides) UNION ALL
         (SELECT 2 as ID, DATE("2017-09-15") as month_check, "Y" as active, 7 as number_of_rides) UNION ALL
         (SELECT 3 as ID, DATE("2017-06-15") as month_check, "Y" as active, 4 as number_of_rides) UNION ALL
         (SELECT 3 as ID, DATE("2017-07-15") as month_check, "Y" as active, 3 as number_of_rides) UNION ALL
         (SELECT 3 as ID, DATE("2017-08-15") as month_check, "Y" as active, 11 as number_of_rides) UNION ALL
         (SELECT 3 as ID, DATE("2017-09-15") as month_check, "Y" as active, 40 as number_of_rides)

         ;;
    }

    dimension: id {
      type: number
      sql: ${TABLE}.ID ;;
    }

    dimension_group: month_check {
      type: time
      sql: ${TABLE}.month_check ;;
    }

    dimension: active {
      type: string
      sql: ${TABLE}.active ;;
    }

    dimension: number_of_rides {
      type: number
      sql: ${TABLE}.number_of_rides ;;
    }

#   dimension: is_mau {
#     type: yesno
#     sql: ${number_of_rides} >= 2 AND DATE_DIFF(CURRENT_DATE(), ${most_recent_ride_date}, DAY) <= 30 AND ${users.is_tester} = false ;;
#   }
#

dimension: is_active_user {
  type: yesno
  sql: ${active}="Y" ;;
}

    measure: count {
      type: count
    }


  }
