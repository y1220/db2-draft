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

ActiveRecord::Schema.define(version: 2022_04_25_093010) do

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
    t.boolean "is_insolvent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password"
    t.integer "num_fails"
  end

  create_table "employees", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password"
  end

  create_table "optional_product_orders", force: :cascade do |t|
    t.integer "optional_product_id", null: false
    t.integer "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["optional_product_id"], name: "index_optional_product_orders_on_optional_product_id"
    t.index ["order_id"], name: "index_optional_product_orders_on_order_id"
  end

  create_table "optional_products", force: :cascade do |t|
    t.string "name"
    t.integer "monthly_fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "product_package_id", null: false
    t.integer "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "validity_period_id"
    t.datetime "start_date"
    t.boolean "status"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["product_package_id"], name: "index_orders_on_product_package_id"
    t.index ["validity_period_id"], name: "index_orders_on_validity_period_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "amount"
    t.integer "validity_period_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_prices_on_product_id"
    t.index ["validity_period_id"], name: "index_prices_on_validity_period_id"
  end

  create_table "product_compositions", force: :cascade do |t|
    t.integer "product_package_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_compositions_on_product_id"
    t.index ["product_package_id"], name: "index_product_compositions_on_product_package_id"
  end

  create_table "product_packages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_composition_id"
    t.index ["product_composition_id"], name: "index_product_packages_on_product_composition_id"
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

  create_table "service_activation_schedules", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "customer_id", null: false
    t.datetime "activation_date"
    t.datetime "deactivation_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_service_activation_schedules_on_customer_id"
    t.index ["order_id"], name: "index_service_activation_schedules_on_order_id"
  end

  create_table "validity_periods", force: :cascade do |t|
    t.integer "period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "alerts", "customers"
  add_foreign_key "optional_product_orders", "optional_products"
  add_foreign_key "optional_product_orders", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "product_packages"
  add_foreign_key "orders", "validity_periods"
  add_foreign_key "prices", "products"
  add_foreign_key "prices", "validity_periods"
  add_foreign_key "product_compositions", "product_packages"
  add_foreign_key "product_compositions", "products"
  add_foreign_key "product_packages", "product_compositions"
  add_foreign_key "service_activation_schedules", "customers"
  add_foreign_key "service_activation_schedules", "orders"
end
