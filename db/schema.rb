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

ActiveRecord::Schema.define(version: 20151004151826) do

  create_table "categories", force: true do |t|
    t.string   "name",       limit: 100, null: false
    t.string   "slug",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "employment_type", limit: 20,                  null: false
    t.string   "company",         limit: 50,                  null: false
    t.string   "logo"
    t.string   "url"
    t.string   "position",        limit: 100,                 null: false
    t.string   "location"
    t.text     "description",                                 null: false
    t.text     "how_to_apply",                                null: false
    t.string   "token"
    t.boolean  "is_public",                   default: false
    t.boolean  "is_activated",                default: false
    t.string   "email",           limit: 100,                 null: false
    t.datetime "expires_at"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["category_id"], name: "index_jobs_on_category_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["tag_id"], name: "index_posts_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
