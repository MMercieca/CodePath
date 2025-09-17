class Assignment < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :lecture
  has_many_attached :supporting_documents

  def can_edit?(user)
    return lecture.can_edit?(user)
  end

  def can_view?(user)
    return lecture.can_view?(user)
  end
end
