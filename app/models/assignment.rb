class Assignment < ApplicationRecord
  acts_as_paranoid

  belongs_to :lecture

  def can_edit?(user)
    return lecture.can_edit?(user)
  end

  def can_view?(user)
    return lecture.can_view?(user)
  end
end
