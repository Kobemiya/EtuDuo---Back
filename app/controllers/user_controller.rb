class UserController < ApplicationController
  before_action :identify!, except: %i[create]
  before_action :authorize!, only: %i[create]

  public
  def create
    user_params = params.require(:user).permit(:username)
    user_params['auth0Id'] = @token['sub']
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique => e
    head :conflict
  end

  def index
    render json: @user
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def update
    if @user.update(params.permit(:username))
      render json: @user
    else
      head :unprocessable_entity
    end
  end
end
