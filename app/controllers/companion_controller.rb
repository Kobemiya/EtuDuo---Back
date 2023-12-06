class CompanionController < ApplicationController
  private

  def verify_format
    head :bad_request if /#[A-Fa-f0-9]{6}/.match(body[:skin_color]).nil?
  end


  before_action :authorize!
  before_action :identify!
  before_action :verify_format, only: :update

  public

  def index
    @companion = @user.companion
    render json: @companion
  end

  def update
    body = params.require(:companion).permit(:name, :skin_color)
    @companion = @user.companion
    if @companion.update(body)
      render json: @companion
    else
      head :unprocessable_entity
    end
  end

  def equip_accessory
    @companion = @user.companion
    @accessory = Accessory.find(params[:accessory_id])
    return head :conflict if @companion.accessories.where(id: @accessory.id).exists?
    return head :forbidden unless @user.accessories.where(id: @accessory).exists?
    @companion.accessories.append(@accessory)
    head :no_content
  rescue ActiveRecord::RecordNotFound => e
    head :not_found
  end

  def unequip_accessory
    @companion = @user.companion
    @accessory = Accessory.find(params[:accessory_id])
    return head :conflict unless @companion.accessories.where(id: @accessory.id).exists?
    @companion.accessories.delete(@accessory)
    head :no_content
  rescue ActiveRecord::RecordNotFound => e
    head :not_found
  end
end