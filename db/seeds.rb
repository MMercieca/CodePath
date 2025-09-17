# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Rails.env.development?
  User.create!(email: 'admin@example.com', password: 'password', group_id: 3)
  User.create!(email: 'teacher@example.com', password: 'password', group_id: 2)
  User.create!(email: 'student@example.com', password: 'password', group_id: 1)
end
