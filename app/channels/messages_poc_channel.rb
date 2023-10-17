class MessagesPocChannel < ApplicationCable::Channel
  def subscribed
    print("User #{params[:username]} subscribed to room #{params[:room]} !")
    stream_from "room #{params[:room]}"
    @username = params[:username]
  end

  def unsubscribed
    print("User #{params[:username]} unsubscribed from room #{params[:room]} !")
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    print("Received: #{params}")
    ActionCable.server.broadcast("room #{params[:room]}", data)
  end
end