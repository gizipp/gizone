class DashboardController < ApplicationController
  before_action :authenticate_user!

  def reindex
    Article.__elasticsearch__.create_index! force: true
    Article.__elasticsearch__.refresh_index!

    Article.import
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Reindexed!' }
      format.json { head :no_content }
    end
  end

  def recreate_sitemap
    %x[rake sitemap:clean]
    %x[rake sitemap:create]
    redirect_to :back
  end

  def refresh_sitemap
    %x[rake sitemap:refresh]
    redirect_to :back
  end
end