class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def reindex
    Article.__elasticsearch__.refresh_index!
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Reindexed!' }
      format.json { head :no_content }
    end
  end

  def refresh
    %x[rake sitemap:refresh]
    redirect_to :back
  end
end