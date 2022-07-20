class AddUserFirstName < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firts_name, :string, null: false, default: ""
    add_column :users, :last_name, :string,  null: false, default: ""
    add_column :users, :country, :string, null: false, default: ""
  end
end
