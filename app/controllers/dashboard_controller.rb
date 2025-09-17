class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.teacher?
      @lectures = current_user.lectures
    else
      @lectures =  Lecture.joins(:lecture_students).where(lecture_students: { user_id: current_user.id } )
    end

  end
end