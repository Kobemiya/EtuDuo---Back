class TasksController < ApplicationController
  private
  def get_params
    params.require(:task).permit(:title, :description, :done, :start, :end)
  end

  def verify_access
    head :forbidden unless @user.tasks.where(id: params[:id]).any?
  end

  before_action :identify!
  before_action :verify_access, except: %i[create index]

  public

  def create
    @task = Task.new(get_params)
    @task.author_id = @user.auth0Id
    if @task.save
      render json: @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @tasks = Task.where(author_id: @user.auth0Id) || []
    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    render json: @task
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(get_params)
      render json: @task
    else
      render :new, status: :unprocessable_entity
    end
  end
end
