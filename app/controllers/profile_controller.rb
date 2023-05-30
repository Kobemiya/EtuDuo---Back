class ProfileController < ApplicationController
  before_action :authorize!
  before_action :identify!

  public
  def index
    @profile = @user.profile
    render json: @profile
  end

  def update
    body = params.require(:profile).permit(:start_work, :end_work, :occupation, :prod_period, :start_sleep, :end_sleep)
    @profile = Profile.new(body)
    @profile.user_id = @user.auth0Id
    old_profile = @user.profile
    if @profile.save
      old_profile.destroy if @user.profile.present?
      @user.profile = @profile
      head :no_content
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation, ArgumentError => e
    head :bad_request
  end
end
