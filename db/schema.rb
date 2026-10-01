# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_09_23_041953) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stops", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.integer "stop_type"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "address"
    t.string "contact_name"
    t.string "contact_phone"
    t.integer "status"
    t.date "scheduled_at"
    t.date "completed_at"
    t.integer "package_count"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_stops_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "route_id", null: false
    t.string "driver_name"
    t.string "vehicule_plate"
    t.integer "status"
    t.date "scheduled_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_trips_on_route_id"
  end

  add_foreign_key "stops", "trips"
  add_foreign_key "trips", "routes"
end
