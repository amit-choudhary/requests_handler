class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_request, only: :create

  def create
    comment = @request.comments.build(permitted_params.merge({ user_id: current_user.id }))
    if comment.save
      render json: { name: current_user.name, content: comment.content }, status: :ok
    else
      render json: { message: 'Failed' }, status: :unprocessable_entity
    end
  end

  private
  def load_request
    @request = Request.find_by(id: params[:request_id])
    not_found_json 'Request' unless @request
    if current_user.type == 'Customer'
      @request = Request.find_by(id: params[:request_id], customer_id: current_user.id)
    else
      @request = Request.find_by(id: params[:request_id])
    end
    not_found_json 'Request' unless @request
  end

  def permitted_params
    params.permit(:content, :request_id, :user_id)
  end
end
