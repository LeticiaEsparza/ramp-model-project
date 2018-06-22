connection: "thelook"

include: "leticia_model_exercise.model.lkml"
include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: test{
  extends: [inventory_items]
  hidden:  no
}

explore: events_extended {
  view_name: events
  extends: [events]
}
