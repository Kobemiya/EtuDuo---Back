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
    query_params = request.query_parameters
    if query_params["already_joined"].nil?
      @rooms = Room.all
    elsif query_params["already_joined"] == 'true'
      @rooms = @user.joined_rooms
    elsif query_params["already_joined"] == 'false'
      to_remove = @user.joined_rooms.select { |r| r.id }
      @rooms = Room.where.not(id: to_remove)
    else
      return head :bad_request
    end
    render json: @rooms
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
      @user.joined_rooms.append(@room)
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

  def enter_room
    @room = Room.find(params[:room_id])
    if @room.capacity >= @room.users.length
      render status: :conflict, json: { error: "Room full", description: "Room is already full" }
    elsif @room.password.present? && @room.password != params["password"]
      head :forbidden
    elsif @room.users.exists?(@user.auth0Id)
      render status: :conflict, json: { error: "Already joined", description: "Room is already joined" }
    else
      @user.joined_rooms.append(@room)
      head :ok
    end
  end

  def leave_room
    @room = Room.find(params[:room_id])
    if @room.author_id == @user.auth0Id
      head :method_not_allowed
    elsif @room.users.exists?(@user.auth0Id)
      @room.users.delete(@user)
      head :ok
    else
      head :conflict
    end
  end
end
