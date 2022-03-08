class Api::BaseController < ApplicationController
  include Authentication
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  before_action :authenticate
end
