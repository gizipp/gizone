class Link < ActiveRecord::Base
  belongs_to :blog
  scope :white, -> { where(whitelist: true) }

  def self.fetch_article
    self.white.each do |link|
      @article = MetaInspector.new('http://'+link.blog.domain.to_s+link.path.to_s,
              :warn_level => :store,
              :connection_timeout => 5, :read_timeout => 5)
      article = Article.new
      article.title = @article.best_title
      article.desc =  @article.description
      article.content = Link.get_content_from('http://'+link.blog.domain.to_s+link.path.to_s)
      article.img = @article.images.best
      article.url = 'http://'+link.blog.domain.to_s+link.path.to_s
      article.save!
    end
  end

  private
    def self.get_content_from(uri, selector='body')
      doc = Nokogiri::HTML(open(uri))
      doc.css('script, link').each { |node| node.remove }
      return doc.css(selector).text.split.join(" ")
    end
end
