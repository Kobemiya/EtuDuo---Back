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
    @user.accessories |= [@accessory]
    head :no_content
  end
  
  def remove_accessory
    @accessory = Accessory.find(params[:accessory_id])
    @user.accessories.delete(@accessory)
    head :no_content
  end
end
