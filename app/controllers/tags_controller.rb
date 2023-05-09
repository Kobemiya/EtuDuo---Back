class TagsController < ApplicationController
  private
  def get_params
    params.require(:tag).permit(:name, :color)
  end

  def verify_existence
    head :not_found unless Tag.where(id: params[:id]).exists?
  end

  def verify_access
    head :forbidden unless @user.tags.where(id: params[:id]).exists?
  end

  before_action :authorize!
  before_action :identify!
  before_action :verify_existence, except: %i[create index]
  before_action :verify_access, except: %i[create index]


  public
  def create
    @tag = Tag.new(get_params)
    if @tag.save
      render json: @tag
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end

  def index
    @tags = @user.tags
    render json: @tags
  end

  def show
    @tag = Tag.find(params[:id])
    render json: @tag
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    head :no_content
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(get_params)
      render json: @tag
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end
end