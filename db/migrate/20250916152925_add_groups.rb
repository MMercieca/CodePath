class AddGroups < ActiveRecord::Migration[7.2]
  def up
    Group.create!(name: "user")
    Group.create!(name: "teacher")
    Group.create!(name: "admin")
  end

  def down
    # no-op
  end
end
