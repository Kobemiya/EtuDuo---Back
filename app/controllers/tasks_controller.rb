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

    if task[:recurrence].is_a?(String)
      head :bad_request if task[:recurrence].is_a?(String) && task[:recurrence] != "yearly"
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
    @task = Task.new(task)
    @task.author_id = @user.auth0Id
    if @task.save
      render json: @task
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end

  def index
    @tasks = @user.tasks
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
    if @task.update(get_params)
      render json: @task
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end
end
