class Article < ActiveRecord::Base
  belongs_to :link
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  Article.import
end
