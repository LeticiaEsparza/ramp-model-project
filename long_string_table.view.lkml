view: long_string_table {
  derived_table: {
    sql: SELECT
      "This is a really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really long string" AS string
      , "another string for tesing" as other_string
      UNION ALL
      SELECT
      "This is ANOTHER really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really long string" AS string
       , "another string for testing" as other_string;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: string_dupe {
    type: string
    sql: ${TABLE}.string;;
  }

  dimension: string {
    type: string
    sql: ${TABLE}.string ;;
    drill_fields: [string_dupe]
    html: <a href="{{link}}"> {{ rendered_value | truncate: 15}} </a> ;;
#     html:
#          <html>
#          <head>
#          <style>
#
#           ul{
#               max-width:10ch;
#               word-wrap:normal;
#            }
#          </style>
#          </head>
#          </html>
#         <li> {{value}}</li>
#     ;;
  }

  dimension: other_string {
    type: string
    sql: ${TABLE}.other_string ;;
  }

  set: detail {
    fields: [string]
  }
}
