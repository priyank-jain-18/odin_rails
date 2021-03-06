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

ActiveRecord::Schema.define(version: 20170321161614) do

  create_table "events", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.text     "description"
    t.datetime "event_start_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "attended_event_id"
    t.string   "invited_user"
    t.boolean  "accepted",          default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "mass_users_invitations", force: :cascade do |t|
    t.text     "multiple_users"
    t.integer  "event_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
