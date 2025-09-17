class Assignment < ApplicationRecord
  acts_as_paranoid

  belongs_to :lecture
end
