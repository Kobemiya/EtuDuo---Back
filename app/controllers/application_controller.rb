class ApplicationController < ActionController::API
  public

  def authorize!
    valid, result = verify(raw_token(request.headers))
    head :unauthorized unless valid
    @token ||= result
    print(@token)
  end

  def check_permissions(token, permission)
    permissions = token['scope'] || []
    permissions = permissions.split if permissions.is_a? String
    head :forbidden unless permissions.include?(permission)
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
