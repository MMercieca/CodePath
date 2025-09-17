class LecturesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_access
  
  def validate_access
    return if current_user.admin?
    lecture = Lecture.find(params[:id])
    
    return if lecture.teacher.id == current_user.id
    
    raise AuthorizationException
  end

  def index
    @lectures = current_user.lectures
  end

  def create
    @lecture = Lecture.create!(
      teacher: current_user,
      name: lecture_params[:name],
      description: lecture_params[:description]
    )

    redirect_to "/lectures/#{@lecture.id}"
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

     redirect_to "/assignments/#{assignment.id}"
  end

  def new
  end

  private

  def lecture_params
    params.permit(:id, :name, :description)
  end

end