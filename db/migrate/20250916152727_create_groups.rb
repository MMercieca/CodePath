class CreateGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :groups do |t|
      t.string :name,              null: false, default: ""
      t.timestamps
    end
  end
end
