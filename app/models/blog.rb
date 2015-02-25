class Blog < ActiveRecord::Base
  has_many :links
  has_many :articles
end
