class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Paperclip

  include Searchable
  belongs_to :link
  belongs_to :blog
  has_mongoid_attached_file :thumbnail,
                    :path => 'thumbnails/:id/:style.:extension',
                    :storage => :s3,
                    :styles => { :original => ['150x150#']},
                    :url => ':s3_domain_url',
                    :s3_host_name => 's3-ap-southeast-1.amazonaws.com',
                    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')


  scope :without_thumbnail, -> { where(thumbnail_file_size: nil) }
  scope :without_thumbnail_public_path, -> { where(thumbnail_public_path: nil) }

  validates_attachment :thumbnail, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  field :id, type: String
  field :title, type: String
  field :desc, type: String
  field :content, type: String
  field :img, type: String
  field :url, type: String
  field :share_facebook, type: String
  field :share_twitter, type: String
  field :share_pinterest, type: String
  field :share_gplus, type: String
  field :thumbnail_public_path, type: String

  slug :title

  def fetch_social_signal
    ["twitter","facebook","pinterest","gplus"].each do |signal|
      case signal
        when "twitter"
          self.share_twitter = self.fetch_share_count(signal)
        when "facebook"
          self.share_facebook = self.fetch_share_count(signal)
        when "pinterest"
          self.share_pinterest = self.fetch_share_count(signal)
        when "gplus"
          self.share_gplus = self.fetch_share_count(signal)
      end
    end
    self.save
  end

  def fetch_share_count(source)
    fetcher_rule = self.url_fetcher(source)
    self.parser(fetcher_rule[0], fetcher_rule[1], source)
  end

  def url_fetcher(source)
    url = self.link.full_path
    case source
      when "twitter"
        return ["https://cdn.api.twitter.com/1/urls/count.json?url="+url, "count"]
      when "facebook"
        return ["http://graph.facebook.com/?id="+url, "shares"]
      when "pinterest"
        return ["http://api.pinterest.com/v1/urls/count.json?callback%20&url="+url, "count"]
      when "gplus"
        return ["https://plusone.google.com/_/+1/fastbutton?url="+url, "div#aggregateCount"]
    end
  end

  def parser(uri, key, source)
    case source
      when "pinterest"
        json_response = open(uri).read.gsub('receiveCount(',"").gsub(')',"")
      when "gplus"
        json_response = Nokogiri::HTML(open(uri))
        return json_response.css(key)[0].text.to_i
      else
        json_response = open(uri).read
    end
    share = JSON.parse(json_response)[key]
  end

  def self.collect_thumbnail
    self.without_thumbnail.each do |a|
      a.save_thumbnail
      a.save_thumbnail_path
    end
  end

  def self.collect_thumbnail_public_path
    self.without_thumbnail_public_path.each do |a|
      a.save_thumbnail if a.thumbnail_file_size.nil?
      a.save_thumbnail_path
    end
  end

  def save_thumbnail
    self.thumbnail = self.img
    self.save!
  end

  def save_thumbnail_path
    self.thumbnail_public_path = self.thumbnail.url
    self.save!
  end

  def is_img_active?
    Linkies.response_code(self.img)
  end

  def is_thumbnail_active?
    Linkies.response_code(self.thumbnail.url)
  end

  def g_url
    'http://gizipp.com/' + self.slug
  end
end