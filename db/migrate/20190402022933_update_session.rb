class UpdateSession < ActiveRecord::Migration[5.2]
  def change
    remove_column :sessions, :classes
  end
end
