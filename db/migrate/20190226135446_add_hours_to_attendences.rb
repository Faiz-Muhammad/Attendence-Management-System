class AddHoursToAttendences < ActiveRecord::Migration[5.2]
  def change
    add_column :attendences, :hours, :float
  end
end
