class AddRaitingToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :rate, :integer, default: 0
  end
end
