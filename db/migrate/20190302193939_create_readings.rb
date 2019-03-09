class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.references :report, foreign_key: true
      t.integer :number
      t.string :readings

      t.timestamps
    end
  end
end
