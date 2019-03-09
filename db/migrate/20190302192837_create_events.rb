class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string  :name
      t.string  :track
      t.string  :region
      t.string  :site_cert_date
      t.date    :meter_factory_clibration_date
      t.string  :microphone_location
      t.text :description

      t.timestamps
    end
  end
end
