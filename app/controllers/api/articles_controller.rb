class Api::ArticlesController < Api::BaseController
  require 'net/http'

  def show
    html = Net::HTTP.get(URI.parse(params[:url]))
    render json: html
  end

  def create
    articles = current_user.articles << Article.new(hotspring_id: params[:hotspring_id], url: params[:url])
    article_json = ArticleSerializer.new(articles[-1])
    render json: article_json
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy
    article_json = ArticleSerializer.new(article)
    render json: article_json
  end
end
