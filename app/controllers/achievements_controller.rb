class AchievementsController < ApplicationController
  before_action :authorize!
  before_action :identify!

  def get_params
    params.require(:achievement).permit(:name, :description, :criteria)
  end

  def index
    render json: Achievement.all
  end
  def create
    @achievement = Achievement.new(get_params)
    if @achievement.save
      render json: @achievement
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end

  def show
    @achievement = Achievement.find(params[:id])
    render json: @achievement
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update(get_params)
      render json: @achievement
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy
    head :no_content
  end

  def grant
    @achievement = Achievement.find(params[:id])
    @user_achievement = UserAchievement.new(user: @user, achievement: @achievement, achieved_date: Date.today)
    if @user_achievement.save
      render json: @user_achievement
    else
      head :unprocessable_entity
    end
    head :no_content
  end

  def user_achievements
    render json: @user.achievements
  end
end
