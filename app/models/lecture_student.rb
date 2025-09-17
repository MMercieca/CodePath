class LectureStudent < ApplicationRecord
  belongs_to :lecture
  belongs_to :user

  has_paper_trail
end
