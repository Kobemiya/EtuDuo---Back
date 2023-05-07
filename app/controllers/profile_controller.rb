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
    if !@profile.save
      head :unprocessable_entity
    else
      @user.profile.destroy if @user.profile.present?
      @user.profile = @profile
      head :no_content
    end
  rescue ActiveRecord::NotNullViolation, ArgumentError => e
    head :bad_request
  end
end
