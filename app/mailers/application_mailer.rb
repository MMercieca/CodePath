class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_SENDER", 'from@example.com')
  layout "mailer"
end
