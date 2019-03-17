class CreateReadings < ActiveRecord::Migration[5.0]
  create_table 'events', force: :cascade do |t|
    t.string 'name'
    t.string 'track'
    t.string 'region'
    t.string 'site_cert_date'
    t.date 'meter_factory_clibration_date'
    t.string 'microphone_location'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'groups', force: :cascade do |t|
    t.string 'name'
    t.bigint 'event_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_groups_on_event_id'
  end

  create_table 'readings', force: :cascade do |t|
    t.bigint 'session_id'
    t.integer 'number'
    t.string 'readings'
    t.string 'car_class'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['session_id', 'number'], unique: true, name: 'index_readings_on_session_id'
  end

  create_table 'sessions', force: :cascade do |t|
    t.string 'name'
    t.string 'classes'
    t.string 'ambient_before'
    t.string 'wind_direction'
    t.string 'wind_speed'
    t.string 'weather'
    t.string 'temp'
    t.string 'humidity'
    t.string 'barometer'
    t.string 'reader'
    t.string 'recorder'
    t.string 'field_calibration_time'
    t.string 'battery_level'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'group_id'
    t.index ['group_id'], name: 'index_sessions_on_group_id'
  end

  add_foreign_key 'groups', 'events'
  add_foreign_key 'readings', 'sessions'
  add_foreign_key 'sessions', 'groups'
end
