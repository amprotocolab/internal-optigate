class APIController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound,       with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_param_missing

  private

  def render_not_found(exception)
    message = "Could not find #{exception.model} with ID: #{exception.id}"
    render json: { errors: [message] }, status: :not_found
  end

  def render_param_missing(exception)
    message = "Param is missing or the value is empty: #{exception.param}"
    render json: { errors: [message] }, status: :bad_request
  end
end