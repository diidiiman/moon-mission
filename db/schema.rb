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

ActiveRecord::Schema.define(version: 20171226120513) do

  create_table "cmc_stats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "rank"
    t.decimal "price_usd", precision: 20, scale: 8
    t.decimal "price_btc", precision: 20, scale: 8
    t.decimal "market_cap_usd", precision: 20, scale: 8
    t.decimal "daily_volume", precision: 20, scale: 8
    t.decimal "percent_change_1h", precision: 20, scale: 8
    t.decimal "percent_change_24h", precision: 20, scale: 8
    t.decimal "percent_change_7d", precision: 20, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "token_id"
    t.index ["token_id"], name: "index_cmc_stats_on_token_id"
  end

  create_table "day_tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tw_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "token_id"
    t.index ["token_id"], name: "index_day_tweets_on_token_id"
  end

  create_table "tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ticker"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweet_stats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "count", default: 0
    t.datetime "date"
    t.bigint "token_id"
    t.index ["token_id"], name: "index_tweet_stats_on_token_id"
  end

  create_table "tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "tweet"
    t.string "keywords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "token_id"
    t.index ["token_id"], name: "index_tweets_on_token_id"
  end

  add_foreign_key "cmc_stats", "tokens"
  add_foreign_key "day_tweets", "tokens"
  add_foreign_key "tweet_stats", "tokens"
  add_foreign_key "tweets", "tokens"
end
