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
  field :num_of_crawled, type: Boolean

  slug :domain

  def links_count
    Link.where(blog_id: self.id).count
  end

  def self.fetch_links
    paths = []
    self.fresh.each do |blog|
      @homepage = MetaInspector.new(blog.domain,
              :warn_level => :store,
              :connection_timeout => 5, :read_timeout => 5,
              :headers => { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36" })
      @homepage.links.internal.each do |link|
        uri = URI(link)
        paths << uri.path
      end

      # save
      paths.uniq.each do |path|
        Link.where(path: path).first_or_create(blog_id: blog.id)
      end

      self.update(blog.id,num_of_crawled: blog.num_of_crawled+1)

      # blog.depth.to_i.times do
      #   Link.where(blog_id: blog.id).each do |url|
      #     paths_tmp = []
      #     @single_page = MetaInspector.new(blog.domain+url.path,
      #         :warn_level => :store,
      #         :connection_timeout => 5, :read_timeout => 5,
      #         :headers => { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36" })
      #     @single_page.links.internal.each do |link|
      #       uri = URI(link)
      #       paths_tmp << uri.path
      #       paths = paths - paths_tmp
      #     end
      #   end
      # end

      # # save again
      # paths.uniq.each do |path|
      #   Link.where(path: path).first_or_create(blog_id: blog.id)
      # end
    end
  end
end