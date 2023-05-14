class AccessoriesController < ApplicationController
  private
  def get_params
    params.require(:accessory).permit(:name, :image_path, :body_part)
  end

  before_action :authorize!
  before_action :identify!

  public
  def index
    @accessories = Accessory.all
    render json: @accessories
  end

  def create
    return head :forbidden unless has_permissions("create:accessories")
    @accessory = Accessory.create(get_params)
    if @accessory.save
      render json: @accessory
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  rescue ActiveRecord::RecordNotUnique => e
    head :conflict
  end

  def show
    @accessory = Accessory.find(params[:id])
    render json: @accessory
  end

  def delete
    return head :forbidden unless has_permissions("delete:accessories")
    @accessory = Accessory.find(params[:id])
    @accessory.destroy
    head :not_content
  end

  def update
    return head :forbidden unless has_permissions("update:accessories")
    @accessory = Accessory.find(params[:id])
    if @accessory.update(get_params)
      render json: @accessory
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end
end
