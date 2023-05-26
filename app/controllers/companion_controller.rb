class CompanionController < ApplicationController
  private

  def verify_format
    body = params.require(:companion).permit(:hair_id, :face_id, :hands_id, :neck_id, :torso_id, :legs_id, :feet_id, :name, :skin_color)
    head :bad_request if /#[A-Fa-f0-9]{6}/.match(body[:skin_color]).nil?

    %i[hair_id face_id neck_id hands_id torso_id legs_id feet_id].each do |part|
      next if body[part].nil?
      head :unprocessable_entity unless Accessory.where(body[part]).exists?
    end
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
    body = params.require(:companion).permit(:hair_id, :face_id, :hands_id, :neck_id, :torso_id, :legs_id, :feet_id, :name, :skin_color)
    @companion = Companion.new(body)
    @companion.user_id = @user.auth0Id
    old_companion = @user.companion
    if @companion.save
      old_companion.destroy if old_companion.present?
      @user.companion = @companion
      head :no_content
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation, ArgumentError => e
    head :bad_request
  end
end
