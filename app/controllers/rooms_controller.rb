# frozen_string_literal: true

class RoomsController < ApplicationController
  private

  def get_params
    params.require(:room).permit(:name, :password, :capacity)
  end

  def verify_existence
    head :not_found unless Room.exists?(params[:id])
  end

  def verify_access
    head :forbidden unless @user.created_rooms.exists?(params[:id])
  end

  before_action :authorize!
  before_action :identify!
  before_action :verify_existence, only: %i[update destroy]
  before_action :verify_access, only: %i[update destroy]

  public
  def index
    render json: Room.all
  end

  def show
    @room = Room.find(params[:id])
    render json: @room
  end

  def create
    @room = Room.new(get_params)
    @room.author_id = @user.auth0Id

    if @room.capacity < 1
      head :bad_request
    end
    if @room.save
      render json: @room
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(get_params)
      render json: @room
    else
      head :unprocessable_entity
    end
  rescue ActiveRecord::NotNullViolation => e
    head :bad_request
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    head :no_content
  end
end