class AddAttributesAndAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :name, :string
    add_column :users, :phonenumber, :integer
    add_column :users, :role, :string
  end
end
