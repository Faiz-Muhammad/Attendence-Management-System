class ChangeCheckInAndCheckOutInAttendences < ActiveRecord::Migration[5.2]
  def change
    change_column :attendences, :check_in, :datetime
    change_column :attendences, :check_out, :datetime
  end
end
