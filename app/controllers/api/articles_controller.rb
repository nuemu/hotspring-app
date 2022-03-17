class Api::ArticlesController < Api::BaseController
  require 'net/http'

  def show
    html = Net::HTTP.get(URI.parse(params[:url]))
    render json: html
  end
end
