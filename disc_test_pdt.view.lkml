view: disc_test_pdt {

    derived_table: {
      sql: SELECT id, count(*)
              FROM  products
              GROUP BY id
               ;;
      sql_trigger_value: SELECT CURDATE() ;;
      indexes: ["id"]
    }

    dimension: id {
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: count {
      type: number
      sql: ${TABLE}.`count(*)` ;;
    }

    set: detail {
      fields: [id, count]
    }


}
