module API::V1
  class UsersController < APIController
    before_action :set_user, only: [:show, :update, :destroy]
    # GET /api/v1/users
    def index
      @users = User.all
      render json: @users
    end

    # GET /api/v1/users/1
    def show
      render json: @user
    end

    # POST /api/v1/users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created, location: location(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/users/1
    def update
      if update_with_password_check
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/users/1
    def destroy
      @user.destroy
      head :no_content
    end

    private

    def location(resource)
      url_for(controller: 'users', action: 'show', id: resource.id)
    end

    def user_params
      params.require(:user).permit(*User::ATTRIBUTE_WHITELIST).merge(clean_roles)
    end

    def password_params
      user_params.slice(*User::PASSWORD_PARAMS)
    end

    def password_params?
      password_params.values.any?(&:present?)
    end

    def update_with_password_check
      if password_params?
        @user.update_with_password(user_params)
      else
        @user.update(user_params)
      end
    end

    def clean_roles
      role_ids = params.require(:user)[:role_ids] || []
      Users::RoleSanitizer.role_ids(current_user, params[:id], role_ids)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
