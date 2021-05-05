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

ActiveRecord::Schema.define(version: 2021_04_10_195816) do

  create_table "campaigns", force: :cascade do |t|
    t.string "name", null: false
    t.string "public_key", null: false
    t.string "rebels_edit_key", null: false
    t.string "rebels_status_key", null: false
    t.string "imperial_status_key", null: false
    t.index ["imperial_status_key"], name: "index_campaigns_on_imperial_status_key", unique: true
    t.index ["name"], name: "index_campaigns_on_name", unique: true
    t.index ["public_key"], name: "index_campaigns_on_public_key", unique: true
    t.index ["rebels_edit_key"], name: "index_campaigns_on_rebels_edit_key", unique: true
    t.index ["rebels_status_key"], name: "index_campaigns_on_rebels_status_key", unique: true
  end

  create_table "tokens", force: :cascade do |t|
    t.string "location", null: false
    t.integer "status", limit: 1, null: false
    t.integer "campaign_id", null: false
    t.index ["campaign_id", "location"], name: "index_tokens_on_campaign_id_and_location", unique: true
    t.index ["campaign_id"], name: "index_tokens_on_campaign_id"
  end

  add_foreign_key "tokens", "campaigns"
end
