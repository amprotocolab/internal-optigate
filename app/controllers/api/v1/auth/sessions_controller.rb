module API::V1::Auth
  class SessionsController < DeviseTokenAuth::SessionsController
    skip_before_action :authenticate_user!, only: [:create]

    protected

    def render_create_success
      render json: @resource, serializer: UserLoginSerializer
    end
  end
end
