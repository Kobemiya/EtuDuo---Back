class StatsController < ApplicationController
  before_action :authorize!
  before_action :identify!

  def index
    render json: Stat.all
  end

  def user_stats
    @stat = @user.stat
    render json: @stat
  end
end
