# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120328172606) do

  create_table "matches", :force => true do |t|
    t.date     "date_inserted"
    t.date     "date_played"
    t.integer  "white_id"
    t.integer  "black_id"
    t.float    "white_result"
    t.float    "black_result"
    t.integer  "round_id"
    t.text     "png_text"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "email",                                  :null => false
    t.string   "encrypted_password",                     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "roles_mask",             :default => 0
    t.string   "name",                   :default => ""
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "players", ["confirmation_token"], :name => "index_players_on_confirmation_token", :unique => true
  add_index "players", ["email"], :name => "index_players_on_email", :unique => true
  add_index "players", ["reset_password_token"], :name => "index_players_on_reset_password_token", :unique => true
  add_index "players", ["unlock_token"], :name => "index_players_on_unlock_token", :unique => true

  create_table "ratings", :force => true do |t|
    t.integer  "player_id"
    t.integer  "value"
    t.datetime "date"
    t.integer  "match_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rounds", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "tournament_round_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "status"
  end

  create_table "standings", :force => true do |t|
    t.integer  "round_id"
    t.integer  "player_id"
    t.decimal  "points"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "standings", ["player_id"], :name => "index_standings_on_player_id"
  add_index "standings", ["round_id"], :name => "index_standings_on_round_id"

  create_table "tournament_players", :force => true do |t|
    t.integer  "player_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.date     "date_started"
    t.date     "date_finished"
    t.integer  "status"
    t.integer  "admin_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
