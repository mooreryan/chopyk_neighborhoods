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

ActiveRecord::Schema.define(version: 20140504032455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collapses", force: true do |t|
    t.string   "new_name"
    t.string   "old_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collapses", ["old_name"], name: "index_collapses_on_old_name", unique: true, using: :btree

  create_table "names", force: true do |t|
    t.string   "contig_name"
    t.string   "orf_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequences", force: true do |t|
    t.string   "header"
    t.string   "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sequences", ["header"], name: "index_sequences_on_header", unique: true, using: :btree

end
