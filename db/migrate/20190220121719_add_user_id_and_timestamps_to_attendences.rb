class AddUserIdAndTimestampsToAttendences < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :attendences, default: Time.zone.now
    change_column_default :attendences, :created_at, nil
    change_column_default :attendences, :updated_at, nil
    add_column :attendences, :user_id, :integer
  end
end
