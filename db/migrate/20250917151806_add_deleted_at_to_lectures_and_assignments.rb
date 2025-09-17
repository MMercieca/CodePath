class AddDeletedAtToLecturesAndAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :lectures, :deleted_at, :datetime, null: true
    add_column :assignments, :deleted_at, :datetime, null: true
  end
end
