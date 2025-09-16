class Lecture < ApplicationRecord
  belongs_to :teacher, class_name: "Users", foreign_key: "user_id"
end
