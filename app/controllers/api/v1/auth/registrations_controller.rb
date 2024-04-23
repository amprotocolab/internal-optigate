module API::V1::Auth
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: User::ATTRIBUTE_WHITELIST)
    end
  end
end