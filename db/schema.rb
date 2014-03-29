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

ActiveRecord::Schema.define(:version => 20140329152136) do

  create_table "passenger_status", :force => true do |t|
    t.string   "pnr_number",     :limit => 15
    t.string   "s_no",           :limit => 15
    t.string   "booking_status", :limit => 20
    t.string   "current_status", :limit => 20
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "pnr_table_id"
  end

  create_table "pnr_table", :force => true do |t|
    t.string   "pnr_number",     :limit => 10
    t.string   "train_number",   :limit => 10
    t.string   "train_name",     :limit => 40
    t.datetime "boarding_date"
    t.string   "starting_point", :limit => 10
    t.string   "ending_point",   :limit => 10
    t.string   "reserved_upto",  :limit => 20
    t.string   "boarding_point", :limit => 20
    t.string   "seat_class",     :limit => 10
  end

end
