class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :session, foreign_key: true
      t.string :classes
      t.string :ambient_before
      t.string :wind_direction
      t.string :wind_speed
      t.string :weather
      t.string :temp
      t.string :humidity
      t.string :barometer
      t.string :reader
      t.string :recorder
      t.string :field_calibration_time
      t.string :battery_level

      t.timestamps
    end
  end
end
