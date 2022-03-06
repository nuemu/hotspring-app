class Api::BaseController < ApplicationController
  include Authentication
  before_action :authenticate
end
