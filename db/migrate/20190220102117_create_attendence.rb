class CreateAttendence < ActiveRecord::Migration[5.2]
  def change
    create_table :attendences do |t|
      t.datetime :date, default: Time.now.strftime('%d/%m/%y')
      t.string :reason
    end
  end
end
