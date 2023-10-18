class RoomChannel < ApplicationCable::Channel
  private

  def broadcast_message(data)
    ActionCable.server.broadcast "room_#{params[:room_id]}", {
      type: "chat_message",
      user_id: connection.user.auth0Id,
      content: data
    }
  end

  public

  def subscribed
    return reject unless connection.user.joined_rooms.exists?(params[:room_id])
    stream_from "room_#{params[:room_id]}"
    @room = Room.find(params[:room_id])
  end

  def receive(data)
    broadcast_message(data["content"]) if (data["type"] == "chat_message")
  end
end
