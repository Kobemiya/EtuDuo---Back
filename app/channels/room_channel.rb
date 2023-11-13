class RoomChannel < ApplicationCable::Channel
  private

  @@subscribers = {}

  after_subscribe :add_subscriber_and_broadcast, unless: :subscription_rejected?
  after_unsubscribe :remove_subscriber_and_broadcast, unless: :subscription_rejected?

  def broadcast_message(room_id, data)
    ActionCable.server.broadcast "room_#{room_id}", {
      type: "chat_message",
      user_id: connection.user.auth0Id,
      content: data
    }
  end

  def broadcast_room_status(room_id)
    users_connected = {}
    @@subscribers[room_id].each do |user_id|
      user = User.find(user_id)
      users_connected[user.auth0Id] = {
        username: user.username,
        companion: user.companion.as_json
      }
    end
    ActionCable.server.broadcast "room_#{room_id}", {
      type: "room_status",
      users_connected: users_connected
    }
  end

  def add_subscriber_and_broadcast
    room_id = params[:room_id]
    sleep(0.1)  # absolutely magnificent fix
    @@subscribers[room_id] = [] unless @@subscribers.has_key?(room_id)
    @@subscribers[room_id].append(user.auth0Id)
    broadcast_room_status(params[:room_id])
  end

  def remove_subscriber_and_broadcast
    room_id = params[:room_id]
    return unless @@subscribers[room_id].present?
    @@subscribers[room_id].delete(connection.user.auth0Id)
    broadcast_room_status(params[:room_id])
  end

  public

  def subscribed
    room_id = params[:room_id]
    user = connection.user
    return reject unless user.joined_rooms.exists?(room_id)
    return reject if @@subscribers.has_key?(room_id) && @@subscribers[room_id].any?(user.auth0Id)
    stream_from "room_#{room_id}"
  end

  def receive(data)
    room_id = params[:room_id]
    broadcast_message(room_id, data["content"]) if (data["type"] == "chat_message")
  end
end
