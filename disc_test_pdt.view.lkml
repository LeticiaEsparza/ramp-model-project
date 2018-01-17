view: disc_test_pdt {

    derived_table: {
      sql: SELECT id, count(*)
              FROM  products;
               ;;
    }

    dimension: id {
      type: string
      sql: ${TABLE}.id ;;
    }

    dimension: count {
      type: string
      sql: ${TABLE}.`count(*)` ;;
    }

    set: detail {
      fields: [id, count]
    }


}
