class JwtProcessor
  class << self
    def encode
      payload = {id: 1}
      hmac_secret = 'my$ecretK3y'
      JWT.encode payload, hmac_secret, 'HS256'
    end

    def decode token
      hmac_secret = 'my$ecretK3y'
      begin
        JWT.decode token, 'abc', true, { algorithm: 'HS256' }
      rescue JWT::VerificationError => e

      end
    end
  end
end