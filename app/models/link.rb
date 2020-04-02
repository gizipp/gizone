class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  require 'open-uri'

  belongs_to :blog
  has_one :article
  scope :white, -> { where(whitelist: true) }
  scope :not_black, -> { where(blacklist: false) }
  scope :clean, -> { where(:path.nin => ["/",/^\/category\//i,/^\/tag\//i,/^\/page\//i,
                                          /^\/feed\//i,/^\/rss\//i,/^\/author\//i,
                                          /^\/feeds\//i,/^\/search/i,/_archive./i,
                                          /^\/about\//i]) }
  field :path, type: String
  field :whitelist, type: Boolean, default: false
  field :blacklist, type: Boolean, default: false
  field :unreachable, type: Boolean, default: false

  def fetch_article
    webpage = self.inspect_webpage
    return if webpage.nil?

    self.save_articles(webpage, self.scrap_content) if self.is_without_article?
  end

  def self.fetch_article
    self.white.each do |link|
      if link.is_without_article?
        link.fetch_article
      else
        #reindex goes here. will be updated soon
      end
    end
  end

  def inspect_webpage
    begin
      agents = %w(
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2)]",
         "AppleWebKit/537.36 (KHTML, like Gecko)",
         "Chrome/40.0.2214.111",
         "Safari/537.36"
      )

      webpage = MetaInspector.new(self.full_path,
        :warn_level => :store,
        :connection_timeout => 5, :read_timeout => 5,
        :headers => {
          'User-Agent' => agents.sample
        }
      )
    rescue
      nil
    end
  end

  def scrap_content
    doc = Nokogiri::HTML(open(self.full_path))
    doc.css('script, link').each { |node| node.remove }
    result = {
      title: doc.css(self.blog.title_selector ||= 'h2').text.split.join(" "),
      body: self.add_paragraphs(doc.css(self.blog.content_selector ||= 'body').text.split.join(" "))
      }
    return result
  end

  def full_path
    return 'http://'+self.blog.domain+self.path
  end

  def is_without_article?
    self.article.nil?
  end

  def add_paragraphs(body)
    response = ""
    body.split(/\n/).each do |line|
      if(line != "")
        response += "<p>" + line + "</p>\n"
      end
    end
    return response
  end

  def save_articles(webpage, content)
    a = Article.new
    a.title = content[:title].present? ? content[:title] : webpage.best_title
    a.desc =  webpage.description
    a.content = content[:body]
    a.img = webpage.images.best
    a.thumbnail = webpage.images.best
    a.url = self.full_path
    a.link_id = self.id
    a.blog_id = self.blog_id
    a.save!
  end
end
