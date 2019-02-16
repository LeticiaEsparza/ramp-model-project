view: shipment_mock_table {
  derived_table: {
    sql: SELECT 1 shipment_id, "created" status, CAST("2018-01-01" AS DATE) created
      UNION ALL
      SELECT 1 shipment_id, "delivered" status, CAST("2018-01-07" AS DATE) created
      UNION ALL
      SELECT 2 shipment_id, "created" status, CAST("2018-01-02" AS DATE) created
      UNION ALL
      SELECT 2 shipment_id, "delivered" status, CAST("2018-01-05" AS DATE) created
      UNION ALL
      SELECT 3 shipment_id, "created" status, CAST("2018-01-03" AS DATE) created
      UNION ALL
      SELECT 3 shipment_id, "delivered" status, CAST("2018-01-07" AS DATE) created
       ;;

      sql_trigger_value: SELECT CURDATE();;
      indexes: ["shipment_id"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: shipment_id {
    type: number
    sql: ${TABLE}.shipment_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: created {
    type: date
    sql: ${TABLE}.created ;;
  }

  set: detail {
    fields: [shipment_id, status, created]
  }
}
