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

ActiveRecord::Schema.define(version: 2021_04_10_172504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buyers", force: :cascade do |t|
    t.bigint "external_id"
    t.string "nickname"
    t.string "email"
    t.jsonb "phone", default: {"number"=>"", "area_code"=>""}
    t.string "first_name"
    t.string "last_name"
    t.jsonb "billing_info", default: {"doc_type"=>"", "doc_number"=>""}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.jsonb "item", default: {"id"=>"", "title"=>""}
    t.integer "quantity"
    t.float "unit_price"
    t.float "full_unit_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "external_id"
    t.bigint "store_id"
    t.datetime "date_created"
    t.datetime "date_cloased"
    t.datetime "last_updated"
    t.float "total_amount"
    t.float "total_shipping"
    t.float "total_amount_with_shipping"
    t.float "paid_amount"
    t.datetime "expiration_date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "buyer_id"
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "external_id"
    t.bigint "order_external_id"
    t.bigint "payer_external_id"
    t.integer "installments"
    t.string "payment_type"
    t.string "status"
    t.float "transaction_amount"
    t.float "taxes_amount"
    t.float "shipping_cost"
    t.float "total_paid_amount"
    t.float "installment_amount"
    t.datetime "date_approved"
    t.datetime "date_created"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

end
