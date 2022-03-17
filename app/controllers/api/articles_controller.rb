class Api::ArticlesController < Api::BaseController
  skip_before_action :authenticate
  require 'net/http'

  def show
    html = Net::HTTP.get(URI.parse(params[:url]))
    render json: html
  end

  def create
    url = Hotspring.find(params[:hotspring_id]).articles << Article.new(url: params[:url])
    render json: url[-1]
  end
end
