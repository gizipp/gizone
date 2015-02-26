class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :domain
      t.integer :num_of_crawled, default: 0

      t.timestamps null: false
    end
    add_index :blogs, :domain, unique: true
  end
end
