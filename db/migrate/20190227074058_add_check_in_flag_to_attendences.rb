class AddCheckInFlagToAttendences < ActiveRecord::Migration[5.2]
  def change
    add_column :attendences, :check_in_flag, :boolean
  end
end
