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

ActiveRecord::Schema[7.0].define(version: 2023_07_05_180106) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "name", null: false
    t.string "image_path", null: false
    t.integer "body_part", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_accessories_on_name", unique: true
  end

  create_table "accessories_users", id: false, force: :cascade do |t|
    t.string "user_id"
    t.bigint "accessory_id"
    t.index ["accessory_id"], name: "index_accessories_users_on_accessory_id"
    t.index ["user_id", "accessory_id"], name: "index_accessories_users_on_user_id_and_accessory_id", unique: true
    t.index ["user_id"], name: "index_accessories_users_on_user_id"
  end

  create_table "companions", force: :cascade do |t|
    t.string "name", null: false
    t.string "skin_color", null: false
    t.bigint "face_id"
    t.bigint "hands_id"
    t.bigint "hair_id"
    t.bigint "neck_id"
    t.bigint "torso_id"
    t.bigint "legs_id"
    t.bigint "feet_id"
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["face_id"], name: "index_companions_on_face_id"
    t.index ["feet_id"], name: "index_companions_on_feet_id"
    t.index ["hair_id"], name: "index_companions_on_hair_id"
    t.index ["hands_id"], name: "index_companions_on_hands_id"
    t.index ["legs_id"], name: "index_companions_on_legs_id"
    t.index ["neck_id"], name: "index_companions_on_neck_id"
    t.index ["torso_id"], name: "index_companions_on_torso_id"
    t.index ["user_id"], name: "index_companions_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "start_work", null: false
    t.datetime "end_work", null: false
    t.integer "occupation", null: false
    t.integer "prod_period", null: false
    t.datetime "start_sleep"
    t.datetime "end_sleep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.string "password"
    t.string "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_rooms_on_author_id"
  end

  create_table "rooms_users", id: false, force: :cascade do |t|
    t.string "user_id"
    t.bigint "room_id"
    t.index ["room_id"], name: "index_rooms_users_on_room_id"
    t.index ["user_id", "room_id"], name: "index_rooms_users_on_user_id_and_room_id", unique: true
    t.index ["user_id"], name: "index_rooms_users_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "tags_tasks", id: false, force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.boolean "done", null: false
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author_id"
    t.boolean "unmovable", null: false
    t.string "recurrence"
    t.index ["author_id"], name: "index_tasks_on_author_id"
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "auth0Id", null: false
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth0Id"], name: "index_users_on_auth0Id", unique: true
  end

  add_foreign_key "accessories_users", "accessories", on_delete: :cascade
  add_foreign_key "accessories_users", "users", primary_key: "auth0Id", on_delete: :cascade
  add_foreign_key "companions", "accessories", column: "face_id", on_delete: :nullify
  add_foreign_key "companions", "accessories", column: "feet_id", on_delete: :nullify
  add_foreign_key "companions", "accessories", column: "hair_id", on_delete: :nullify
  add_foreign_key "companions", "accessories", column: "hands_id", on_delete: :nullify
  add_foreign_key "companions", "accessories", column: "legs_id", on_delete: :nullify
  add_foreign_key "companions", "accessories", column: "neck_id", on_delete: :nullify
  add_foreign_key "companions", "accessories", column: "torso_id", on_delete: :nullify
  add_foreign_key "companions", "users", primary_key: "auth0Id", on_delete: :cascade
  add_foreign_key "profiles", "users", primary_key: "auth0Id", on_delete: :cascade
  add_foreign_key "rooms", "users", column: "author_id", primary_key: "auth0Id"
  add_foreign_key "rooms_users", "rooms"
  add_foreign_key "rooms_users", "users", primary_key: "auth0Id"
  add_foreign_key "tags", "users", primary_key: "auth0Id", on_delete: :cascade
  add_foreign_key "tags_tasks", "tags", on_delete: :cascade
  add_foreign_key "tags_tasks", "tasks", on_delete: :cascade
  add_foreign_key "tasks", "users", column: "author_id", primary_key: "auth0Id", on_delete: :cascade
end
