class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable

  has_paper_trail

  has_many :lectures, foreign_key: "user_id"

  def admin?
    group_id == 3
  end

  def teacher?
    group_id == 2 || admin?
  end

  def invite_link
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    self.update!(reset_password_token: hashed, reset_password_sent_at: Time.now.utc)

    Rails.application.routes.url_helpers.edit_user_password_url(
      reset_password_token: raw,
      host: ENV.fetch("HOST_NAME", "http://localhost:3000")
    )
  end
end
