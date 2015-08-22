class HomeController < ApplicationController
  def index
    @articles = Article.all.page(params[:page]).limit(5).order("created_at DESC")
  end

  def search
    @articles = Article.search(params[:q]).page(params[:page]).results
    render action: "search"
  end
end