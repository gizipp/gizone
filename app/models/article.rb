class Article < ActiveRecord::Base
  self.per_page = 2
  include Searchable
  belongs_to :link
end
