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

ActiveRecord::Schema.define(version: 2019_02_22_122839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "contact"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "variant_id"
    t.string "product"
    t.boolean "active", default: true
    t.index ["shop_id"], name: "index_accounts_on_shop_id"
  end

  create_table "buttons", force: :cascade do |t|
    t.string "button_name"
    t.string "notify_message"
    t.string "form_title"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "install"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

end
