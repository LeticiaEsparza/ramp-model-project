view: pdt_test {

    derived_table: {
      sql: SELECT id, products.category FROM products
              GROUP BY category;;
              datagroup_trigger: pdt_test_datagroup
              indexes: ["id"]

    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: category {
      type: string
      sql: ${TABLE}.category ;;
    }

    dimension:  id {
      type: number
      sql: ${TABLE}.id ;;
    }

    set: detail {
      fields: [category]
    }

}
