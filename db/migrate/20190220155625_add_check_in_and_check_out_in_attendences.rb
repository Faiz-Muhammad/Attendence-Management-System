class AddCheckInAndCheckOutInAttendences < ActiveRecord::Migration[5.2]
  def change
    add_column :attendences, :month, :string, default: Date.today.strftime("%B")
    add_column :attendences, :check_in, :date
    add_column :attendences, :check_out, :date
  end
end
