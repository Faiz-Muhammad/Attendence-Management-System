class ChangeColumnInAttendences < ActiveRecord::Migration[5.2]
  def change
    change_column :attendences, :date, :date, default: Time.now.strftime('%Y/%m/%d')
  end
end
