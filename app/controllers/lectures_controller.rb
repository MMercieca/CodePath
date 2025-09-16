class LecturesController < ApplicationController
  before_action :authenticate_user!
  
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

  def new
  end

  private

  def lecture_params
    params.permit(:id, :name, :description)
  end

end