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

ActiveRecord::Schema.define(version: 2022_07_14_124639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "hotspring_id", null: false
    t.bigint "user_id", null: false
    t.text "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspring_id"], name: "index_articles_on_hotspring_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
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
    t.text "description", null: false
    t.text "image_url"
    t.boolean "fix", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "prefecture"
    t.index ["latitude", "longtitude"], name: "index_hotsprings_on_latitude_and_longtitude", unique: true
  end

  create_table "mountains", force: :cascade do |t|
    t.string "name", null: false
    t.string "ruby"
    t.string "prefecture", null: false
    t.string "location", null: false
    t.string "height", null: false
    t.float "latitude", null: false
    t.float "longtitude", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["latitude", "longtitude"], name: "index_mountains_on_latitude_and_longtitude", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "hotspring_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspring_id"], name: "index_posts_on_hotspring_id"
    t.index ["user_id", "hotspring_id"], name: "index_posts_on_user_id_and_hotspring_id", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.bigint "hotspring_id", null: false
    t.bigint "mountain_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotspring_id", "mountain_id"], name: "index_spots_on_hotspring_id_and_mountain_id", unique: true
    t.index ["hotspring_id"], name: "index_spots_on_hotspring_id"
    t.index ["mountain_id"], name: "index_spots_on_mountain_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "admin", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "introduce", default: "未記入", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "hotsprings"
  add_foreign_key "articles", "users"
  add_foreign_key "comments", "hotsprings"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "hotsprings"
  add_foreign_key "favorites", "users"
  add_foreign_key "posts", "hotsprings"
  add_foreign_key "posts", "users"
  add_foreign_key "spots", "hotsprings"
  add_foreign_key "spots", "mountains"
end
