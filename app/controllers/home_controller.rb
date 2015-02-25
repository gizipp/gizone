class HomeController < ApplicationController
  def index
    @page = MetaInspector.new('http://backpackstory.me/2015/02/01/kaleidoskop-2014-tahun-penuh-pencapaian/',
            :warn_level => :store,
            :connection_timeout => 5, :read_timeout => 5)
    @page.links.internal.each do |link|
      uri = URI(link)
    end
  end

  private
  def user_agent
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36"
  end
end
