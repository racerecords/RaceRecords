class AddStartTimeAndEndTimeToSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :start_time, :datetime
    add_column :sessions, :end_time, :datetime
  end
end
