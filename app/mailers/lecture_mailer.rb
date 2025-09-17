class LectureMailer < ApplicationMailer
  def invite_new_student(student, url)
    @student = student
    @url = url
    mail(to: student.email, subject: "You have been invited to a lecture on Alexandria")
  end

end
