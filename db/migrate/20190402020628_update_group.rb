class UpdateGroup < ActiveRecord::Migration[5.2]
  change_table :groups do |t|
    t.string :car_classes
  end
end
