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
    
    if params[:supporting_documents].present?
      params[:supporting_documents].each do |f|
        @assignment.supporting_documents.attach(f)
      end
    end
    @assignment.save
    flash[:notice] = "Saved"

    redirect_to "/assignments/#{@assignment.id}/edit"
  end

  def delete_supporting_document
    assignment = Assignment.find(params[:id])
    doc = assignment.supporting_documents.find(params[:file_id])

    if doc.nil?
      flash[:error] = "Document not found"
      return redirect_to "/assignments/#{assignment.id}"
    end

    doc.destroy
    flash[:notice] = "Deleted"

    redirect_to "/assignments/#{assignment.id}/edit"

  end

  def delete
    assignment = Assignment.find(params[:id])
    lecture = assignment.lecture
    assignment.destroy
    flash[:notice] = "Deleted"

    redirect_to "/lectures/#{lecture.id}"
  end

  private

  def assignment_params
    params.permit(:id, :position, :content, :name, :supporting_files)
  end
end