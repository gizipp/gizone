class Blog
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  has_many :links
  has_many :articles
  scope :fresh, -> { where(num_of_crawled: 0) }

  field :domain, type: String
  field :title_selector, type: String
  field :content_selector, type: String
  field :num_of_crawled, type: Integer, default: 0

  slug :domain do |cur_object|
    blacklist = ['dot', 'slash', 'www']
    cur_object.slug_builder.to_url.split("-").reject{ |c| blacklist.include?c }.join("-")
  end

  def fetch_links
    webpage = self.inspect_webpage
    return if webpage.nil?

    paths = self.fetch_paths(webpage)
    self.save_path(paths)
    self.add_one_num_of_crawled if paths.uniq.count != 0
  end

  def self.fetch_links
    self.shall_be_fetched.each do |blog|
      blog.fetch_links
    end
  end

  def self.without_links
    @blogs_zero_links = []
    self.all.each do |blog|
      @blogs_zero_links << blog if blog.links_count == 0
    end
    return @blogs_zero_links
  end

  def self.shall_be_fetched
    @blogs = []
    self.fresh.each do |blog|
      @blogs << blog
    end
    self.without_links.each do |blog|
      @blogs << blog
    end
    return @blogs.uniq
  end

  def inspect_webpage
    begin
      agents = %w(
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2)]",
         "AppleWebKit/537.36 (KHTML, like Gecko)",
         "Chrome/40.0.2214.111",
         "Safari/537.36"
      )

      @webpage = MetaInspector.new(self.domain,
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

  def fetch_paths(webpage)
    paths = []
    webpage.links.internal.each do |link|
      uri = URI(link)
      paths << uri.path
    end
    return paths
  end

  def save_path(paths)
    paths.uniq.each do |path|
      Link.where(path: path).first_or_create(blog_id: self.id)
    end
  end

  def add_one_num_of_crawled
    self.update_attribute(:num_of_crawled, self.num_of_crawled + 1)
  end

  def links_count
    return Link.where(blog_id: self.id).count
  end
end
