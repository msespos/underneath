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

ActiveRecord::Schema.define(version: 2022_04_03_160628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_bombs", force: :cascade do |t|
    t.integer "x_position"
    t.integer "y_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "x_position"
    t.integer "y_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id"
    t.boolean "face_up"
    t.string "type"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "turn"
    t.uuid "human_player_id"
    t.uuid "worm_player_id"
    t.string "phase"
    t.integer "humans_bombs"
    t.string "last_revealed_card_message"
  end

  create_table "humans", force: :cascade do |t|
    t.boolean "alive"
    t.integer "x_position"
    t.integer "y_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id"
    t.integer "play_order"
  end

  create_table "worms", force: :cascade do |t|
    t.boolean "alive"
    t.integer "x_position"
    t.integer "y_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id"
    t.integer "last_move_x_direction"
    t.integer "last_move_y_direction"
    t.boolean "emergent"
  end

end
