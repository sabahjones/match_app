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

ActiveRecord::Schema.define(version: 20170327205211) do

  create_table "ethnicities", force: :cascade do |t|
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "profile_id"
  end

  create_table "ethnicities_profiles", id: false, force: :cascade do |t|
    t.integer "ethnicity_id", null: false
    t.integer "profile_id",   null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "height"
    t.string   "body_type"
    t.string   "status"
    t.string   "has_kids"
    t.string   "wants_kids"
    t.string   "education"
    t.string   "smoking"
    t.string   "drinking"
    t.string   "religion"
    t.integer  "salary"
    t.text     "interests"
    t.text     "specifications"
    t.text     "essay"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "zip_code"
    t.string   "gender"
    t.date     "birthday"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "is_active",       default: true
  end

end