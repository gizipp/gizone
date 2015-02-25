class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :desc
      t.text :content
      t.string :img
      t.string :url

      t.timestamps null: false
    end
    add_index :articles, :url, unique: true
  end
end
