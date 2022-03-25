class Api::BaseController < ApplicationController
  include Authentication
  before_action :authenticate
  after_action :set_csrf_token_header
end
