class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  require 'open-uri'

  belongs_to :blog
  has_one :article
  scope :white, -> { where(whitelist: true) }

  field :path, type: String
  field :whitelist, type: Boolean
  field :blacklist, type: Boolean
  field :unreachable, type: Boolean

  def self.fetch_article
    self.white.each do |link|
      if link.article.nil?
        @article = MetaInspector.new('http://'+link.blog.domain.to_s+link.path.to_s,
                :warn_level => :store,
                :connection_timeout => 5, :read_timeout => 5)
        a = Link.scrap('http://'+link.blog.domain.to_s+link.path.to_s, link.blog.title_selector, link.blog.content_selector)
        article = Article.new
        article.title = a[:title].present? ? a[:title] : @article.best_title
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
        content: add_paragraphs(doc.css(content_selector).text.split.join(" "))
        }
    end

    def self.add_paragraphs(body)
      response = ""
      body.split(/\n/).each do |line|
        if(line != "")
          response += "<p>" + line + "</p>\n"
        end
      end
      return response
    end
end