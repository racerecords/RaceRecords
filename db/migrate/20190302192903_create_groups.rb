class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :car_class, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
