require 'jwt'
require 'net/http'

class JsonWebToken
  class << self
    def algo
      'RS256'
    end

    def issuer
      Rails.application.config_for(:auth0)[:issuerUri]
    end

    def key(header)
      jwks_hash[header['kid']]
    end

    def jwks_hash
      jwks_raw = Net::HTTP.get(URI("https://#{issuer}/.well-known/jwks.json"))
      jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
      jwks_keys.map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(Base64.decode64(k['x5c'].first)).public_key
        ]
      end.to_h
    end

    def verify(token)
      JWT.decode(token, nil,
                 true, # Verify the signature of this token
                 algorithm: algo,
                 issuer: issuer,
                 verify_iss: true,
                 aud: Rails.application.config_for(:auth0)[:audience],
                 verify_aud: true) do |header|
        key(header)
      end
    end
  end
end