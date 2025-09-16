class AddDefaultGroupForUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :group_id, :integer, default: 1
  end
end
