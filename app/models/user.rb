class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable

  has_many :lectures, foreign_key: "user_id"

  def admin?
    group_id == 3
  end

  def teacher?
    group_id == 2 || admin?
  end
end
