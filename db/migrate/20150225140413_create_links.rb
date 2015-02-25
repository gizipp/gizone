class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :path
      t.boolean :whitelist, default: false
      t.boolean :blacklist, default: false
      t.boolean :unreachable, default: false
      t.integer :blog_id

      t.timestamps null: false
    end
    add_index :links, :path, unique: true
    add_index :links, :blog_id
  end
end
