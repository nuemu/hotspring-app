class Api::ArticlesController < Api::BaseController
  skip_before_action :authenticate
  require 'net/http'

  def show
    html = Net::HTTP.get(URI.parse(params[:url]))
    render json: html
  end

  def create
    articles = Hotspring.find(params[:hotspring_id]).articles << Article.new(url: params[:url])
    article = ArticleSerializer.new(articles[-1])
    render json: article
  end
end
