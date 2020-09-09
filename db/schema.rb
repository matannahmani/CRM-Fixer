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

ActiveRecord::Schema.define(version: 2020_09_09_103812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calloptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "help_option_id"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["help_option_id"], name: "index_calloptions_on_help_option_id"
    t.index ["user_id"], name: "index_calloptions_on_user_id"
  end

  create_table "calls", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.integer "phone"
    t.string "address"
    t.bigint "city_id"
    t.string "email"
    t.string "description"
    t.boolean "healthcheck"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_calls_on_city_id"
    t.index ["user_id"], name: "index_calls_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "help_options", force: :cascade do |t|
    t.string "descriptionvol"
    t.string "descriptioncall"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "useroptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "help_option_id"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["help_option_id"], name: "index_useroptions_on_help_option_id"
    t.index ["user_id"], name: "index_useroptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastname"
    t.string "name"
    t.boolean "gender"
    t.integer "phone"
    t.string "address"
    t.boolean "student"
    t.bigint "city_id"
    t.integer "adminlevel", default: 0
    t.integer "israelid"
    t.boolean "healthcheck"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "calloptions", "help_options"
  add_foreign_key "calloptions", "users"
  add_foreign_key "calls", "cities"
  add_foreign_key "calls", "users"
  add_foreign_key "useroptions", "help_options"
  add_foreign_key "useroptions", "users"
  add_foreign_key "users", "cities"
end
