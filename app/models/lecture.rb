# frozen_string_literal: true

# Why call a collection of assignments a lecture?  Because `class` is a reserved word and I couldn't think 
# of a better one. I'm open to suggestions, but `lecture` does imply class sessions, assignments, etc. -MPM
class Lecture < ApplicationRecord
  belongs_to :teacher, class_name: "User", foreign_key: "user_id"
end
