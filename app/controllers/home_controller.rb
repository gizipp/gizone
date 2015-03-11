class HomeController < ApplicationController
  def index
  end

  def search
    @articles = Article.search(params[:q]).records
    render action: "search"
  end
end