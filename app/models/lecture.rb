# frozen_string_literal: true

# Why call a collection of assignments a lecture?  Because `class` is a reserved word and I couldn't think 
# of a better one. I'm open to suggestions, but `lecture` does imply class sessions, assignments, etc. -MPM
class Lecture < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :teacher, class_name: "User", foreign_key: "user_id"
  has_many :assignments, foreign_key: "lecture_id", dependent: :destroy
  has_many :lecture_students
  has_many :students, through: :lecture_students, source: :user

  def can_edit?(user)
    return user.admin? || user_id == user.id
  end

  def can_view?(user)
    return true if can_edit?(user)
    
    return students.include?(user)
  end
end
