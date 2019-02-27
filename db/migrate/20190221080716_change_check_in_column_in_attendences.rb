class ChangeCheckInColumnInAttendences < ActiveRecord::Migration[5.2]
  def change
    change_column :attendences, :check_in, :time
    change_column :attendences, :check_out, :time
  end
end
