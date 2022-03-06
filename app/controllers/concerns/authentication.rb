module Authentication
  include 'jwt'

  KEY = Rails.application.credentials.secret_key_base

  def encode(user_id)
    expires_in = 7.days.from_now.to_i
    preload = { user_id: user_id, exp: expires_in }
    JWT.encode(preload, KEY, 'HS256')
  end

  def decode(token)
    JWT.decode(token, KEY, true, algorithm: 'HS256')
  end

  private

  def current_user
    @_current_user
  end

  def authenticate
    authenticate_or_request_with_http_basic do |token|
      @_current_user = User.find(decode(token))
    end
  end
end
