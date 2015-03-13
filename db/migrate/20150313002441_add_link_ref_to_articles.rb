class AddLinkRefToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :link, index: true
    add_foreign_key :articles, :links
  end
end
