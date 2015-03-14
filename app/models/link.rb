class Link < ActiveRecord::Base
  require 'open-uri'

  belongs_to :blog
  has_one :article
  scope :white, -> { where(whitelist: true) }

  def self.fetch_article
    self.white.each do |link|
      if link.article.nil?
        @article = MetaInspector.new('http://'+link.blog.domain.to_s+link.path.to_s,
                :warn_level => :store,
                :connection_timeout => 5, :read_timeout => 5)
        a = Link.scrap('http://'+link.blog.domain.to_s+link.path.to_s)
        article = Article.new
        article.title = @article.best_title.blank? ? a[:title] : @article.best_title
        article.desc =  @article.description
        article.content = a[:content]
        article.img = @article.images.best
        article.url = 'http://'+link.blog.domain.to_s+link.path.to_s
        article.link_id = link.id
        article.save!
      end
    end
  end

  private
    def self.scrap(uri, title_selector='h2', content_selector='body')
      doc = Nokogiri::HTML(open(uri))
      doc.css('script, link').each { |node| node.remove }
      result = {
        title: doc.css(title_selector).text.split.join(" "),
        content: doc.css(content_selector).text.split.join(" ")
        }
    end
end
