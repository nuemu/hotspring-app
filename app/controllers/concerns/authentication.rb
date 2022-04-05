module Authentication
  include ActionController::HttpAuthentication::Token::ControllerMethods
  require 'jwt'
  require 'google/apis/drive_v3'
  require 'googleauth'

  KEY = Rails.application.credentials.secret_key_base

  def encode(user_id)
    expires_in = 7.days.from_now.to_i
    preload = { user_id: user_id, exp: expires_in }
    JWT.encode(preload, KEY, 'HS256')
  end

  def decode(token)
    JWT.decode(token, KEY, true, algorithm: 'HS256').first
  end

  private

  def current_user
    @_current_user || User.find_by(name: 'Guest')
  end

  def authenticate
    authenticate_with_http_token do |token|
      user_id = decode(token)['user_id']
      @_current_user = User.find(user_id)
    end
  end

  def google_drive_initializer
    scope = 'https://www.googleapis.com/auth/drive'

    f = File.new('tmp/service.json', 'w+')
    f.write(ENV['GOOGLE_DRIVE'])
    f.close

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('tmp/service.json'),
      scope: scope
    )
    authorizer.fetch_access_token!

    @drive = Google::Apis::DriveV3::DriveService.new
    @drive.authorization = authorizer
  end
end
