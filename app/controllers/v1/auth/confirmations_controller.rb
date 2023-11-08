module API::V1::Auth
  class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
    skip_before_action :authenticate_user!
  end
end
