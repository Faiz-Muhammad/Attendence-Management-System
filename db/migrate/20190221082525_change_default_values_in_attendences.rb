class ChangeDefaultValuesInAttendences < ActiveRecord::Migration[5.2]
  def change
    change_column :attendences, :date, :date, default: nil
    change_column :attendences, :month, :string, default: nil
  end
end
