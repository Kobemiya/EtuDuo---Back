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

ActiveRecord::Schema[7.0].define(version: 2023_04_05_161622) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.boolean "done", null: false
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author_id"
    t.index ["author_id"], name: "index_tasks_on_author_id"
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "auth0Id", null: false
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth0Id"], name: "index_users_on_auth0Id", unique: true
  end

  add_foreign_key "tasks", "users", column: "author_id", primary_key: "auth0Id"
end
