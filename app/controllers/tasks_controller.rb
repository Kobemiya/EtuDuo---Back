class TasksController < ApplicationController
  private
  def get_params
    task = params.require(:task).permit(:title, :description, :done, :start, :end, :unmovable, :recurrence, recurrence: [], tags: [])

    task[:tags].map!{ |tag_id| Tag.find(tag_id) } if task[:tags].present?
    task[:recurrence] = task[:recurrence].uniq.join(",") if task[:recurrence].is_a?(Array)

    task
  end

  def verify_existence
    head :not_found unless Task.where(id: params[:id]).exists?
  end

  def verify_access
    head :forbidden unless @user.tasks.where(id: params[:id]).exists?
  end

  def verify_format
    task = params.require(:task).permit(:title, :description, :done, :start, :end, :unmovable, :recurrence, recurrence: [], tags: [])

    if task.key?(:tags)
      head :bad_request if task[:tags].nil?
      head :bad_request unless task[:tags].all?{ |tag_id| Tag.where(id: tag_id).exists? }
    end

    head :bad_request if task[:start].nil? || task[:end].nil? && task[:recurrence].present?

    if task[:recurrence].is_a?(String)
      head :bad_request unless task[:recurrence] == "yearly"
    elsif task[:recurrence].is_a?(Array)
      week_days = %w[monday tuesday wednesday thursday friday saturday sunday]
      head :bad_request unless task[:recurrence].all?{ |day| day.is_a?(String) && week_days.include?(day) }
    elsif task[:recurrence].present?
      head :bad_request
    end
  end

  before_action :authorize!
  before_action :identify!
  before_action :verify_existence, except: %i[create index]
  before_action :verify_access, except: %i[create index]
  before_action :verify_format, only: %i[create update]

  public

  def create
    task = get_params
    return head :bad_request if task[:tags].nil?
    task[:recurrence] = nil if task[:recurrence].blank?
    @task = Task.new(task)
    @task.author_id = @user.auth0Id
    if @task.save
      @user.stat.tasks_created += 1
      @user.update(stat: @user.stat)
      if @user.stat.tasks_created == 10
        @user_achievement = UserAchievement.new(user: @user, achievement: Achievement.find_by(id: 1), achieved_date: Date.today)
        @user_achievement.save
      end
      render json: @task
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end

  def index
    query_params = request.query_parameters
    return head :bad_request unless query_params.all? { |scope, _| %w[date].any?(scope) }

    @tasks = @user.tasks

    if query_params['date']
      date = query_params['date'].to_datetime
      from = date.beginning_of_day
      to = date.end_of_day

      days_of_week = %w[monday tuesday wednesday thursday friday saturday sunday]
      @tasks = @tasks.where("(start IS NULL OR start <= :to) AND (tasks.end IS NULL OR tasks.end >= :from) OR " +
                           "(recurrence = 'yearly' AND (SUBSTR(start::varchar, 5) <= SUBSTR(:to, 5))::int + (SUBSTR(tasks.end::varchar, 5) >= SUBSTR(:from, 5))::int + (SUBSTR(start::varchar, 5) > SUBSTR(tasks.end::varchar, 5))::int = 2) OR " +
                           "recurrence LIKE :day_selection",
                         from: from, to: to, day_selection: "*#{days_of_week[date.wday]}*")

      @tasks = @tasks.map { |task|
        if task.recurrence == "yearly"
          years_diff =  ((to.to_time - task.start.to_time) / 1.year).floor.to_i
          task.start = task.start.next_year(years_diff)
          task.end = task.end.next_year(years_diff)
        elsif task.recurrence.present?
          task.start = task.start.change(years: date.year, month: date.month, day: date.day)
          task.end = task.end.change(years: date.year, month: date.month, day: date.day)
        end
        task.start = [task.start.to_time, from.to_time].max
        task.end = [task.end.to_time, to.to_time].min
        task
      }
    end

    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    head :no_content
  end

  def update
    @task = Task.find(params[:id])
    if @task.done != get_params[:done]
      @user.stat.tasks_done += 1
      @user.update(stat: @user.stat)
    end
    if @task.update(get_params)
      render json: @task
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end
end
