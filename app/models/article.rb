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

  validates_attachment :thumbnail, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  field :id, type: String
  field :title, type: String
  field :desc, type: String
  field :content, type: String
  field :img, type: String
  field :url, type: String

  slug :title
end