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

ActiveRecord::Schema.define(version: 2024_03_20_194401) do

  create_table "bands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "instrument_music_tracks", force: :cascade do |t|
    t.integer "instrument_id", null: false
    t.integer "music_track_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instrument_id"], name: "index_instrument_music_tracks_on_instrument_id"
    t.index ["music_track_id"], name: "index_instrument_music_tracks_on_music_track_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "track_conversation_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "content"
    t.boolean "deleted", default: false
    t.index ["track_conversation_id"], name: "index_messages_on_track_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "music_genre_music_tracks", force: :cascade do |t|
    t.integer "music_track_id", null: false
    t.integer "music_genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["music_genre_id"], name: "index_music_genre_music_tracks_on_music_genre_id"
    t.index ["music_track_id"], name: "index_music_genre_music_tracks_on_music_track_id"
  end

  create_table "music_genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "music_tracks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "band_id"
    t.integer "parent_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["parent_id"], name: "index_music_tracks_on_parent_id"
    t.index ["user_id"], name: "index_music_tracks_on_user_id"
  end

  create_table "track_conversations", force: :cascade do |t|
    t.integer "music_track_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["music_track_id"], name: "index_track_conversations_on_music_track_id"
  end

  create_table "user_conversations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "conversation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_user_conversations_on_conversation_id"
    t.index ["user_id"], name: "index_user_conversations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "instrument_music_tracks", "instruments"
  add_foreign_key "instrument_music_tracks", "music_tracks"
  add_foreign_key "messages", "track_conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "music_genre_music_tracks", "music_genres"
  add_foreign_key "music_genre_music_tracks", "music_tracks"
  add_foreign_key "music_tracks", "music_tracks", column: "parent_id", on_delete: :cascade
  add_foreign_key "music_tracks", "users"
  add_foreign_key "track_conversations", "music_tracks"
  add_foreign_key "user_conversations", "track_conversations", column: "conversation_id"
  add_foreign_key "user_conversations", "users"
end
