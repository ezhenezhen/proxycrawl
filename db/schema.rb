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

ActiveRecord::Schema.define(version: 20171020070620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crawlers", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_active",        default: true
    t.string   "status"
    t.string   "link"
    t.datetime "last_ran_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "comment"
    t.integer  "last_crawl_count", default: 0
  end

  create_table "proxies", force: :cascade do |t|
    t.string   "ip"
    t.string   "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "crawler_id"
  end

  create_table "socks", force: :cascade do |t|
    t.string   "ip"
    t.string   "port"
    t.string   "socks_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
