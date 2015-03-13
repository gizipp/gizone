class HomeController < ApplicationController
  def index
  end

  def search
    @articles = Article.search(params[:q]).page(params[:page]).results
    render action: "search"
  end
end