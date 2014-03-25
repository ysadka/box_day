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

ActiveRecord::Schema.define(version: 20140325224716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name",       default: "", null: false
    t.date     "date",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prizes", force: true do |t|
    t.string   "name",       null: false
    t.integer  "event_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.string   "body",           default: "",    null: false
    t.boolean  "replied",        default: false, null: false
    t.string   "username",       default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attached_photo"
    t.boolean  "iron_mention",   default: true
  end

  create_table "users", force: true do |t|
    t.string   "username",     default: "", null: false
    t.string   "provider",     default: "", null: false
    t.string   "uid",          default: "", null: false
    t.string   "oauth_token",  default: "", null: false
    t.string   "oauth_secret", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "winners", id: false, force: true do |t|
    t.integer  "prize_id",   null: false
    t.integer  "tweet_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "winners", ["prize_id"], name: "index_winners_on_prize_id", using: :btree
  add_index "winners", ["tweet_id"], name: "index_winners_on_tweet_id", using: :btree

end
