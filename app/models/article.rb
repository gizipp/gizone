class Article
  # include Mongoid::Slug
  include Mongoid::Document
  include Mongoid::Timestamps

  include Searchable
  belongs_to :link
  belongs_to :blog

  field :id, type: String
  field :title, type: String
  field :desc, type: String
  field :content, type: String
  field :img, type: String
  field :url, type: String

  # slug :title
end