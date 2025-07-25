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

ActiveRecord::Schema[8.0].define(version: 2025_06_23_092134) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "surname", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "shop_item_id", null: false
    t.integer "quantity", default: 1, null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["shop_item_id"], name: "index_order_items_on_shop_item_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "shop_item_categories", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shop_item_categories_shop_items", id: false, force: :cascade do |t|
    t.bigint "shop_item_id", null: false
    t.bigint "shop_item_category_id", null: false
    t.index ["shop_item_category_id"], name: "index_shop_item_categories_shop_items_on_shop_item_category_id"
    t.index ["shop_item_id", "shop_item_category_id"], name: "index_shop_item_category_shop_item", unique: true
    t.index ["shop_item_id"], name: "index_shop_item_categories_shop_items_on_shop_item_id"
  end

  create_table "shop_items", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "shop_items"
  add_foreign_key "orders", "customers"
  add_foreign_key "shop_item_categories_shop_items", "shop_item_categories"
  add_foreign_key "shop_item_categories_shop_items", "shop_items"
end
