class PreviewController < ApplicationController
  def preview
    # raise params[:url].inspect
    @url = params[:url]
  end
end