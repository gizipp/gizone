class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :domain
      t.string :depth

      t.timestamps null: false
    end
    add_index :blogs, :domain, unique: true
  end
end
