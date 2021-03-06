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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150405232137) do

  create_table "centers", force: :cascade do |t|
    t.string   "site_name"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "admin_number"
    t.string   "website"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "pop_type_desc"
    t.string   "location_desc"
    t.string   "site_status"
    t.string   "location_type_desc"
    t.string   "center_type_desc"
    t.string   "op_schedule_desc"
    t.string   "op_calendar"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "state_name"
    t.string   "county_name"
    t.string   "full_county_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "phone"
    t.string   "query"
    t.text     "data"
    t.integer  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
