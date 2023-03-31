class TasksController < ApplicationController
  def get_params
    params.require(:task).permit(:title, :description, :done, :author, :start, :end)
  end

  before_action :authorize!

  public

  def create
    @todo = Task.new(get_params)
    if @todo.save
      render json: @todo
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @todos = Task.all
    render json: @todos
  end

  def show
    @todo = Task.find(params[:id])
    render json: @todo
  end

  def destroy
    @todo = Task.find(params[:id])
    @todo.destroy
    render json: @todo
  end

  def update
    @todo = Task.find(params[:id])

    if @todo.update(get_params)
      render json: @todo
    else
      render :new, status: :unprocessable_entity
    end
  end
end
