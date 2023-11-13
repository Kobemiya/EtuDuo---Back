require 'json_web_token'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    private

    identified_by :user

    def verify(token)
      payload, = JsonWebToken.verify(token)
      [true, payload]
    rescue JWT::DecodeError => e
      [false, e]
    end

    public

    def connect
      return reject_unauthorized_connection unless request.headers['Authorization'].present?
      valid, token = verify(request.headers['Authorization'].split.last)
      return reject_unauthorized_connection unless valid
      user = User.find(token['sub'])
      return reject_unauthorized_connection unless user.present?
      @user = user
    end
  end
end
