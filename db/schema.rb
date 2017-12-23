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

ActiveRecord::Schema.define(version: 20171223115434) do

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

  create_table "tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ticker"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cmc_stats", "tokens"
end
