class StatsController < ApplicationController
  before_action :authorize!
  before_action :identify!

  def index
    render json: Stat.all
  end

  def user_stats
    @stat = @user.stat
    @res = {
      id: @stat.id,
      tasks_done: @stat.tasks_done,
      tasks_created: @stat.tasks_created
    }
    render json: @res
  end
end
