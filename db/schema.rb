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

ActiveRecord::Schema.define(version: 20170403112741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crawlers", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_active",   default: true
    t.string   "status"
    t.string   "link"
    t.datetime "last_ran_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "tag"
    t.string   "link"
    t.string   "content"
    t.text     "label",      default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_issues_on_user_id", using: :btree
  end

  create_table "labels", force: :cascade do |t|
    t.integer  "issues_id"
    t.string   "name"
    t.string   "color"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["issues_id"], name: "index_labels_on_issues_id", using: :btree
  end

  create_table "proxies", force: :cascade do |t|
    t.string   "ip"
    t.string   "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "crawler_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "is_admin",               default: false
    t.string   "users"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "avatar_file"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "roles_mask",             default: 1
    t.index "(((roles_mask & 1) <> 0))", name: "index_users_on_roles_mask_bit_1", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 128) <> 0))", name: "index_users_on_roles_mask_bit_128", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 16) <> 0))", name: "index_users_on_roles_mask_bit_16", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 2) <> 0))", name: "index_users_on_roles_mask_bit_2", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 256) <> 0))", name: "index_users_on_roles_mask_bit_256", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 32) <> 0))", name: "index_users_on_roles_mask_bit_32", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 4) <> 0))", name: "index_users_on_roles_mask_bit_4", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 512) <> 0))", name: "index_users_on_roles_mask_bit_512", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 64) <> 0))", name: "index_users_on_roles_mask_bit_64", where: "(roles_mask <> 0)", using: :btree
    t.index "(((roles_mask & 8) <> 0))", name: "index_users_on_roles_mask_bit_8", where: "(roles_mask <> 0)", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["roles_mask"], name: "index_users_on_roles_mask", using: :btree
  end

end
