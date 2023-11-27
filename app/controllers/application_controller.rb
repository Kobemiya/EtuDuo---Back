require 'json_web_token'

class ApplicationController < ActionController::API
  public

  def authorize!
    valid, result = verify(raw_token(request.headers))
    begin render status: :unauthorized,
           json: { "error": "Invalid token", "description": "User not registered in Auth0, invalid, expired or empty token" }
    end unless valid
    @token ||= result
  end

  def identify!
    exist = User.where(auth0Id: @token['sub']).exists?
    begin render status: :unauthorized,
           json: { "error": "Invalid user", "description": "User not found in DB, but present on Auth0, server might be desyncronized with DB" }
    end unless exist
    @user = User.find(@token['sub']) if exist
  end

  def has_permissions(permission)
    permissions = @token['permissions'] || []
    permissions = permissions.split if permissions.is_a? String
    permissions.include?(permission)
  end

  private

  def verify(token)
    payload, = JsonWebToken.verify(token)
    [true, payload]
  rescue JWT::DecodeError => e
    [false, e]
  end

  def raw_token(headers)
    return headers['Authorization'].split.last if headers['Authorization'].present?
    nil
  end
end
