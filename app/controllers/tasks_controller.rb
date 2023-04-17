class TasksController < ApplicationController
  private
  def get_params
    task_params = params.require(:task).permit(:title, :description, :done, :start, :end, :unmovable, :recurrence, tags: [])
    task_params[:tags] ||= []
    task_params[:tags].map! { |tag_id| Tag.find(tag_id) }
    task_params
  end

  def verify_existence
    head :not_found unless Task.where(id: params[:id]).exists?
  end

  def verify_access
    head :forbidden unless @user.tasks.where(id: params[:id]).exists?
  end

  before_action :authorize!
  before_action :identify!
  before_action :verify_existence, except: %i[create index]
  before_action :verify_access, except: %i[create index]

  public

  def create
    @task = Task.new(get_params)
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
