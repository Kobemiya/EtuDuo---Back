class InventoryController < ApplicationController
  private 
  
  before_action :authorize!
  before_action :identify!
  
  public 
  def index
    @accessories = @user.accessories
    render json: @accessories
  end
  
  def add_accessory
    @accessory = Accessory.find(params[:accessory_id])
    if @user.accessories.where(id: @accessory.id).exists?
      head :conflict
    else
      @user.accessories.append(@accessory)
      head :no_content
    end
  end
  
  def remove_accessory
    @accessory = Accessory.find(params[:accessory_id])
    if @user.accessories.where(id: @accessory.id).exists?
      @user.accessories.delete(@accessory)
      head :no_content
    else
      head :not_found
    end
  end
end
