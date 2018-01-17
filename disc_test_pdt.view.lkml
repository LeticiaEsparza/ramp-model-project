view: disc_test_pdt {

    derived_table: {
      sql: SELECT id, count(*), category
              FROM  products
              GROUP BY category
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

    dimension: category {
      type: string
      sql: ${TABLE}.category ;;
    }

    set: detail {
      fields: [id, count]
    }


}
