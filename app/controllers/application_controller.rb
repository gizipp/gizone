class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def index
    Article.__elasticsearch__.create_index! force: true
    Article.__elasticsearch__.refresh_index!

    Article.import
  end
end
