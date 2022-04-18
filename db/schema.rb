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

ActiveRecord::Schema.define(version: 2022_04_18_195438) do

  create_table "alerts", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "username"
    t.string "email"
    t.integer "amount"
    t.integer "numOfFailedPayments"
    t.datetime "lastRejectionDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_alerts_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.boolean "isSolvent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prices", force: :cascade do |t|
    t.integer "amount"
    t.integer "validityPeriod_id", null: false
    t.integer "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_prices_on_service_id"
    t.index ["validityPeriod_id"], name: "index_prices_on_validityPeriod_id"
  end

  create_table "product_packages", force: :cascade do |t|
    t.string "name"
    t.integer "price_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["price_id"], name: "index_product_packages_on_price_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "productType"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "validity_periods", force: :cascade do |t|
    t.integer "period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "alerts", "customers"
  add_foreign_key "prices", "services"
  add_foreign_key "prices", "validityPeriods"
  add_foreign_key "product_packages", "prices"
end
