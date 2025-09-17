class CreateAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :assignments do |t|
      t.references :lecture, null: false, foreign_key: true
      t.string :name
      t.text :content
      t.integer :position, default: 1

      t.timestamps
    end
  end
end
