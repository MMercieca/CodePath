class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_access
  
  def validate_access
    return if current_user.admin?
    assignment = Assignment.find(params[:id])
    
    return if assignment.lecture.teacher.id == current_user.id
    
    raise AuthorizationException
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:id])

    @assignment.name = params[:name]
    @assignment.content = params[:content]
    @assignment.position = params[:position]
    @assignment.save
  
    redirect_to "/assignments/#{@assignment.id}/edit"
  end

  private

  def assignment_params
    params.permit(:id, :position, :content, :name)
  end
end