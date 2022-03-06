class Api::BaseController < ApplicationController
  include Authentication
  protect_from_forgery
  before_action :authenticate
end
