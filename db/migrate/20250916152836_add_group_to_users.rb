class AddGroupToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :group_id, :integer, null: false
  end
end
