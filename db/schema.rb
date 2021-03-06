# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_10_111041) do

  create_table "campaigns", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "turn", default: 1, null: false
    t.boolean "start_turn", default: true, null: false
    t.index ["name"], name: "index_campaigns_on_name", unique: true
  end

  create_table "fleet_elements", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "turn", limit: 1, null: false
    t.boolean "start_turn", default: true, null: false
    t.boolean "owned", default: true, null: false
    t.boolean "scarred", default: false, null: false
    t.boolean "destroyed", default: false, null: false
    t.boolean "spare", default: false, null: false
    t.integer "cost", limit: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_fleet_elements_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "campaign_id", null: false
    t.string "side"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id", "user_id"], name: "index_players_on_campaign_id_and_user_id", unique: true
  end

# Could not dump table "tokens" because of following StandardError
#   Unknown type 'bool' for column 'diplomat'

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "avatar", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "fleet_elements", "players"
  add_foreign_key "players", "campaigns"
  add_foreign_key "players", "users"
  add_foreign_key "tokens", "campaigns"
end
