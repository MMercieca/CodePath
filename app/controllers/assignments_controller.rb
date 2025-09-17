class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_write, only: [:update, :edit, :delete]
  before_action :validate_view, only: [:show]
  
  def validate_write
    assignment = Assignment.find(params[:id])
    return if assignment.can_edit?(current_user)

    raise AuthorizationException
  end

  def validate_view
    assignment = Assignment.find(params[:id])
    return if assignment.can_view?(current_user)

    raise AuthorizationException
  end

  def index
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

  def delete
    assignment = Assignment.find(params[:id])
    lecture = assignment.lecture
    assignment.destroy

    redirect_to "/lectures/#{lecture.id}"
  end

  private

  def assignment_params
    params.permit(:id, :position, :content, :name)
  end
end