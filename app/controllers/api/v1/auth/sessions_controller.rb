module API::V1::Auth
  class SessionsController < DeviseTokenAuth::SessionsController
    protected

    def render_create_success
      render json: @resource, serializer: UserLoginSerializer
    end
  end
end
