class LecturesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_write, only: [:create_assignment, :delete, :edit, :add_students, :remove_student]
  before_action :validate_view, only: [:show]

  def validate_write
    lecture = Lecture.find(params[:id])
    return if lecture.can_edit?(current_user)
    
    raise AuthorizationException
  end

  def validate_view
    lecture = Lecture.find(params[:id])
    return if lecture.can_view?(current_user)

    raise AuthorizationException
  end

  def index
    @lectures = current_user.lectures
  end

  def create
    return unless current_user.teacher? || current_user.admin?

    @lecture = Lecture.create!(
      teacher: current_user,
      name: lecture_params[:name],
      description: lecture_params[:description]
    )

    redirect_to "/lectures/#{@lecture.id}"
  end

  def edit
    @lecture = Lecture.find(params[:id])
  end

  def update
    @lecture = Lecture.find(params[:id])
    @lecture.name = lecture_params[:name]
    @lecture.description = lecture_params[:description]
    @lecture.save
    flash[:notice] = "Saved"

    redirect_to "/lectures/#{@lecture.id}/edit"
  end

  def delete
    lecture = Lecture.find(params[:id])
    lecture.destroy
    flash[:notice] = "Deleted"

    redirect_to "/dashboard"
  end

  def show
    @lecture = Lecture.find(params[:id])
  end

  def create_assignment
    lecture = Lecture.find(params[:id])
    position = lecture.assignments&.pluck(:position)&.max
    position = position || 1
    assignment = Assignment.create!(
      lecture: lecture,
      position: position
     )

     redirect_to "/assignments/#{assignment.id}/edit"
  end

  def add_students
    @lecture = Lecture.find(params[:id])
  end

  def remove_student
    @lecture = Lecture.find(params[:id])
    lecture_student = LectureStudent.find_by(lecture_id: @lecture.id, user_id: params[:student_id])
    
    if !lecture_student
      flash[:error] = "Could not find that student in this class"
    else
      lecture_student.destroy
      flash[:notice] = "Student has been removed from class"
    end
    redirect_to "/lectures/#{@lecture.id}"
  end

  def add_student(lecture, email)
    student = User.find_by(email: email)

    if !student
      student = User.create!(email: email, group_id: 3, password: SecureRandom.uuid.to_s)
      link = student.invite_link
      LectureMailer.invite_new_student(student, link).deliver_now
    end

    LectureStudent.create!(lecture: lecture, user: student)
  end

  def show_add_students
    @lecture = Lecture.find(params[:id])
  end

  def add_students
    @lecture = Lecture.find(params[:id])
    student_emails = lecture_params[:student_emails]

    student_emails = student_emails.gsub(/,/, "\n")
    student_emails.split("\n").each do |email|
      add_student(@lecture, email.strip)
    end

    flash[:notice] = "Students added"
    redirect_to "/lectures/#{@lecture.id}"
  end

  def new
  end

  private

  def lecture_params
    params.permit(:id, :name, :description, :student_emails, :student_id)
  end

end