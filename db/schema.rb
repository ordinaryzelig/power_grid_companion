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

ActiveRecord::Schema.define(version: 2019_03_10_035925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "card_id", null: false
    t.bigint "player_id", null: false
    t.integer "bidder_ids", null: false, array: true
    t.integer "price"
    t.index ["card_id"], name: "index_auctions_on_card_id"
    t.index ["game_id"], name: "index_auctions_on_game_id"
    t.index ["player_id"], name: "index_auctions_on_player_id"
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "game_id"
    t.integer "number"
    t.integer "kinds"
    t.integer "resources_required"
    t.integer "cities"
    t.bigint "player_id"
    t.index ["game_id", "number"], name: "index_cards_on_game_id_and_number", unique: true
    t.index ["game_id"], name: "index_cards_on_game_id"
    t.index ["player_id"], name: "index_cards_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_games_on_token", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "name", null: false
    t.integer "color", null: false
    t.integer "balance", default: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "turn_order", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "resource_market_spaces", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "cost"
    t.index ["game_id"], name: "index_resource_market_spaces_on_game_id"
  end

  create_table "resources", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "kind", null: false
    t.string "owner_type"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_resources_on_game_id"
    t.index ["owner_type", "owner_id"], name: "index_resources_on_owner_type_and_owner_id"
  end

  add_foreign_key "auctions", "cards"
  add_foreign_key "auctions", "games"
  add_foreign_key "auctions", "players"
  add_foreign_key "cards", "games"
  add_foreign_key "cards", "players"
  add_foreign_key "players", "games"
  add_foreign_key "resource_market_spaces", "games"
  add_foreign_key "resources", "games"
end
