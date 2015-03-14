# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150313002441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "desc"
    t.text     "content"
    t.string   "img"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "link_id"
  end

  add_index "articles", ["link_id"], name: "index_articles_on_link_id", using: :btree
  add_index "articles", ["url"], name: "index_articles_on_url", unique: true, using: :btree

  create_table "blogs", force: :cascade do |t|
    t.string   "domain"
    t.string   "title_selector"
    t.string   "content_selector"
    t.integer  "num_of_crawled",   default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "blogs", ["domain"], name: "index_blogs_on_domain", unique: true, using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "path"
    t.boolean  "whitelist",   default: false
    t.boolean  "blacklist",   default: false
    t.boolean  "unreachable", default: false
    t.integer  "blog_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "links", ["blog_id"], name: "index_links_on_blog_id", using: :btree
  add_index "links", ["path"], name: "index_links_on_path", unique: true, using: :btree

  add_foreign_key "articles", "links"
end
