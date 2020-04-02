class DashboardController < ApplicationController
  before_action :authenticate_user!

  def reindex
    Article.__elasticsearch__.create_index! force: true
    Article.__elasticsearch__.refresh_index!

    Article.import
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Reindexed!' }
      format.json { head :no_content }
    end
  end

  def recreate_sitemap
    %x[rake sitemap:clean]
    %x[rake sitemap:create]
    redirect_back fallback_location: root_path
  end

  def refresh_sitemap
    %x[rake sitemap:refresh]
    redirect_back fallback_location: root_path
  end
end
