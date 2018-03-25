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

ActiveRecord::Schema.define(version: 20180325092252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string  "traid_key"
    t.integer "reviewing_user_id"
    t.float   "rating"
    t.string  "text"
    t.integer "user_id"
  end

  create_table "traid_logs", force: :cascade do |t|
    t.json     "history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "key"
  end

  create_table "traids", force: :cascade do |t|
    t.string   "title"
    t.string   "conditions"
    t.string   "offer"
    t.string   "offer_type"
    t.string   "offer_subtype"
    t.string   "quantity"
    t.string   "key"
    t.integer  "user_id",               limit: 8,                 null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "status"
    t.boolean  "is_reviewable_by_user",           default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.date     "birthday"
    t.string   "gender"
    t.string   "email"
    t.string   "phone_number"
    t.string   "password_digest"
    t.string   "address"
    t.string   "secondary_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
    t.string   "is_offering",       array: true
    t.string   "is_seeking",        array: true
    t.string   "about"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "reviews", "users"
end
