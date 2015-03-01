class Link < ActiveRecord::Base
  belongs_to :blog
  scope :white, -> { where(whitelist: true) }

  def self.fetch_article
    self.white.each do |link|
      @article = MetaInspector.new('http://'+link.blog.domain.to_s+link.to_s,
              :warn_level => :store,
              :connection_timeout => 5, :read_timeout => 5)
      article = Article.new
      article.title = @article.best_title
      article.desc =  @article.description
      article.content =  @article.description
      article.img = @article.images.best
      article.url = 'http://'+link.blog.domain.to_s+link.to_s
      article.save!
    end
  end
end
