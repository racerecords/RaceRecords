json.extract! report, :id, :session_id, :classes, :ambient_before, :wind_direction, :wind_speed, :weather, :temp, :humidity, :barometer, :reader, :recorder, :site_certification_date, :microphone_location, :field_calibration_time, :battery_level, :created_at, :updated_at
json.url report_url(report, format: :json)
