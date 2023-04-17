class TagsController < ApplicationController
  private
  def get_params
    params.require(:tag).permit(:name, :color)
  end

  before_action :identify!

  public
  def create
    @tag = Tag.new(get_params)
    if @tag.save
      render json: @tag
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @tags = Tag.all
    render json: @tags
  end

  def show
    @tag = Tag.find(params[:id])
    render json: @tag
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    render json: @tag
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(get_params)
      render json: @tag
    else
      render :new, status: :unprocessable_entity
    end
  end
end