class Group < ApplicationRecord
  def change
    create_table :groups do |t|
      t.string :name,              null: false, default: ""
    end
  end
end
