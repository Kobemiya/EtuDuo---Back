class ProfileController < ApplicationController
  before_action :authorize!
  before_action :identify!

  public
  def index
    @profile = @user.profile
    render @profile
  end

  def update
    body = params.require(:profile).permit(:start_work, :end_work, :occupation, :prod_period, :start_sleep, :end_sleep)
    head :no_content
    if @user.profile.present?
      head :unprocessable_entity unless @user.profile.update(body)
      @profile = @user.profile
    else
      @profile = Profile.new(body)
      if @profile.save
        @user.profile = @profile
      else
        head :unprocessable_entity
      end
    end
  rescue ActiveRecord::NotNullViolation, ArgumentError => e
    head :bad_request
  end
end
