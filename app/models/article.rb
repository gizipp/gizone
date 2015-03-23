class Article < ActiveRecord::Base
  include Searchable
  belongs_to :link
end
