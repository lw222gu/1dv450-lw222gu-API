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

ActiveRecord::Schema.define(version: 20160225110359) do

  create_table "clients", force: :cascade do |t|
    t.string   "name",        limit: 50,                 null: false
    t.string   "description", limit: 250
    t.string   "url"
    t.string   "key"
    t.boolean  "active",                  default: true, null: false
    t.integer  "user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id"

  create_table "locations", force: :cascade do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resource_owners", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salaries", force: :cascade do |t|
    t.integer  "wage",                          null: false
    t.string   "title",             limit: 250, null: false
    t.integer  "resource_owner_id"
    t.integer  "location_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "salaries_tags", id: false, force: :cascade do |t|
    t.integer "salary_id", null: false
    t.integer "tag_id",    null: false
  end

  add_index "salaries_tags", ["salary_id", "tag_id"], name: "index_salaries_tags_on_salary_id_and_tag_id"
  add_index "salaries_tags", ["tag_id", "salary_id"], name: "index_salaries_tags_on_tag_id_and_salary_id"

  create_table "tags", force: :cascade do |t|
    t.string   "tag",        limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.integer  "role_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
