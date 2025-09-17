class LecturesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_write, only: [:create_assignment, :delete, :edit]
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

  def new
  end

  private

  def lecture_params
    params.permit(:id, :name, :description)
  end

end