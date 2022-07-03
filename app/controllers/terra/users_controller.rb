module Terra
  class UsersController < BaseController
    before_action :authenticate_user!, only: [:show]
    def new
      @user = User.new
    end

    def create
      operation = Operations::Users::Create.new
      result = operation.call(user_params)

      case result
      in Success
        flash[:success] = "User successfully created"
        redirect_to terra_root_path
      in Failure[error, payload]
        flash[:error] = "While creating user went wronf: #{payload}"
        redirect_to new_terra_user_path
      end
    end

    def show
      @user = User.find_by(id: params[:id])
    end

    private
    def user_params
      params.require(:user).permit(:email, :password, :firts_name, :last_name, :country)
    end
  end
end