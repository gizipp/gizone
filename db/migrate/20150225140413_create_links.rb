class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :path
      t.boolean :whitelist, default: false
      t.boolean :blacklist, default: false
      t.boolean :unreachable, default: false

      t.timestamps null: false
    end
    add_index :links, :path, unique: true
  end
end
