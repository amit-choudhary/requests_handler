class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_requests, only: :index
  before_action :initialize_request, only: :index
  before_action :allow_customer, only: :create
  before_action :load_request, only: [:show, :assign, :solve]
  before_action :allow_support_agent, only: :assign

  def index
  end

  def new
  end

  def show
  end

  def create
    @request = Request.new(permitted_params_for_create.merge(customer_id: current_user.id))
    if @request.save
      flash[:notice] = 'Request Submitted successfully.'
    else
      flash[:alert] = @request.errors.full_messages.to_sentence
    end
    redirect_to requests_path
  end

  def assign
    if @request.update(support_agent_id: current_user.id)
      flash[:notice] = 'Request assigned successfully'
    else
      flash[:alert] = @request.errors.full_messages.to_sentence
    end
    redirect_to request_path(@request)
  end

  def solve
    if @request.update(status: 'solved')
      flash[:notice] = 'Request solved successfully'
    else
      flash[:alert] = @request.errors.full_messages.to_sentence
    end
    redirect_to request_path(@request)
  end

  private

  def initialize_request
    @request = Request.new
  end

  def permitted_params_for_create
    params.require(:request).permit(:subject, :content)
  end

  def load_request
    if current_user.type == 'Customer'
      @request = Request.find_by(id: params[:id], customer_id: current_user.id)
    else
      @request = Request.find_by(id: params[:id])
    end
    return if @request
    flash[:alert] = 'Request not found'
    redirect_to requests_path
  end

  def load_requests
    if current_user.type == 'Customer'
      @requests = current_user.requests.order(:created_at)
    else
      @requests = Request.all.order(:created_at)
    end
  end

  def allow_customer
    return if current_user.type == 'Customer'
    flash[:alert] = 'Unauthorized'
    redirect_to requests_path
  end

  def allow_support_agent
    return if current_user.type == 'SupportAgent'
    flash[:alert] = 'Unauthorized'
    redirect_to requests_path
  end
end
