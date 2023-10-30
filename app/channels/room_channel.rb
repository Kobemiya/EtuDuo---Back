class RoomChannel < ApplicationCable::Channel
  private

  @@subscribers = {}

  after_subscribe :broadcast_room_status_callback
  after_unsubscribe :broadcast_room_status_callback

  def broadcast_message(room_id, data)
    ActionCable.server.broadcast "room_#{room_id}", {
      type: "chat_message",
      user_id: connection.user.auth0Id,
      content: data
    }
  end

  def broadcast_room_status_callback
    sleep(0.1)  # absolutely magnificent fix
    broadcast_room_status(params[:room_id])
  end

  def broadcast_room_status(room_id)
    ActionCable.server.broadcast "room_#{room_id}", {
      type: "room_status",
      users_connected: @@subscribers[room_id]
    }
  end

  public

  def subscribed
    room_id = params[:room_id]
    user = connection.user
    return reject unless user.joined_rooms.exists?(room_id)
    return reject if @@subscribers.has_key?(room_id) && @@subscribers[room_id].any?(user.auth0Id)
    stream_from "room_#{room_id}"
    @@subscribers[room_id] = [] unless @@subscribers.has_key?(room_id)
    @@subscribers[room_id].append(user.auth0Id)
  end

  def unsubscribed
    room_id = params[:room_id]
    return @@subscribers.delete(room_id) if @@subscribers[room_id].size == 1
    @@subscribers[room_id].delete(connection.user.auth0Id)
  end


  def receive(data)
    room_id = params[:room_id]
    broadcast_message(room_id, data["content"]) if (data["type"] == "chat_message")
  end
end
