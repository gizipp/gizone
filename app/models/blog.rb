class Blog < ActiveRecord::Base
  has_many :links
  has_many :articles

  def self.fetch_links
    paths = []
    Blog.all.each do |blog|
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

      blog.depth.to_i.times do
        Link.where(blog_id: blog.id).each do |url|
          paths_tmp = []
          @single_page = MetaInspector.new(blog.domain+url.path,
              :warn_level => :store,
              :connection_timeout => 5, :read_timeout => 5,
              :headers => { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36" })
          @single_page.links.internal.each do |link|
            uri = URI(link)
            paths_tmp << uri.path
            paths = paths - paths_tmp
          end
        end
      end

      # save again
      paths.uniq.each do |path|
        Link.where(path: path).first_or_create(blog_id: blog.id)
      end
    end
  end
end