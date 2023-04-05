class UserController < ApplicationController
  private
  def get_params
    params.require(:user).permit(:username)
  end

  before_action :identify!, except: %i[create]
  before_action :authorize!, only: %i[create]

  public
  def create
    user_params = get_params
    user_params['auth0Id'] = @token['sub']
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    render json: @user
  end

  def destroy
    @user.destroy
    render json: @user
  end

  def update
    if @user.update(get_params)
      render json: @user
    else
      render :new, status: :unprocessable_entity
    end
  end
end
