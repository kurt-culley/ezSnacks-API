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

ActiveRecord::Schema.define(version: 20170430160753) do

  create_table "menu_categories", force: :cascade do |t|
    t.integer "restaurant_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menu_categories_on_restaurant_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "menu_category_id"
    t.string "name"
    t.float "price"
    t.string "image_url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_category_id"], name: "index_menu_items_on_menu_category_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "status"
    t.integer "payment_id"
    t.integer "table_id"
    t.text "items_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id"
    t.integer "status"
    t.string "braintree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

end
