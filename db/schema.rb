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

ActiveRecord::Schema.define(version: 2022_03_18_030432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.bigint "hotspring_id", null: false
    t.text "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspring_id"], name: "index_articles_on_hotspring_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hotspring_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspring_id"], name: "index_comments_on_hotspring_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hotspring_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspring_id"], name: "index_favorites_on_hotspring_id"
    t.index ["user_id", "hotspring_id"], name: "index_favorites_on_user_id_and_hotspring_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "hotsprings", force: :cascade do |t|
    t.string "name", default: "未探索", null: false
    t.integer "status", default: 0, null: false
    t.float "latitude", null: false
    t.float "longtitude", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "hotspring_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspring_id"], name: "index_posts_on_hotspring_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "admin", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "articles", "hotsprings"
  add_foreign_key "comments", "hotsprings"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "hotsprings"
  add_foreign_key "favorites", "users"
  add_foreign_key "posts", "hotsprings"
  add_foreign_key "posts", "users"
end
