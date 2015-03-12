class HomeController < ApplicationController
  def index
  end

  def search
    @articles = Article.search(params[:q]).records.paginate(:page => params[:page], :per_page => 1)
    render action: "search"
  end
end