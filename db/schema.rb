# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_02_193939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "track"
    t.string "region"
    t.string "site_cert_date"
    t.date "meter_factory_clibration_date"
    t.string "microphone_location"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_groups_on_event_id"
  end

  create_table "readings", force: :cascade do |t|
    t.bigint "report_id"
    t.integer "number"
    t.string "readings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_readings_on_report_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "session_id"
    t.string "classes"
    t.string "ambient_before"
    t.string "wind_direction"
    t.string "wind_speed"
    t.string "weather"
    t.string "temp"
    t.string "humidity"
    t.string "barometer"
    t.string "reader"
    t.string "recorder"
    t.string "field_calibration_time"
    t.string "battery_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_reports_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_sessions_on_group_id"
  end

  add_foreign_key "groups", "events"
  add_foreign_key "readings", "reports"
  add_foreign_key "reports", "sessions"
  add_foreign_key "sessions", "groups"
end
