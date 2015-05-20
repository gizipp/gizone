class PreviewController < ApplicationController
  def preview
    @url = params[:url]
  end
end