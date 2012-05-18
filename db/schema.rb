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

ActiveRecord::Schema.define(:version => 20120518225706) do

  create_table "metrics", :force => true do |t|
    t.integer  "report_id",                 :null => false
    t.integer  "server_id"
    t.string   "query",                     :null => false
    t.integer  "scale",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "metrics", ["report_id"], :name => "index_metrics_on_report_id"
  add_index "metrics", ["server_id", "report_id"], :name => "index_metrics_on_server_id_and_report_id"
  add_index "metrics", ["server_id"], :name => "index_metrics_on_server_id"

  create_table "reports", :force => true do |t|
    t.string   "name",                            :null => false
    t.string   "description"
    t.text     "queries",     :limit => 16777215
    t.integer  "server_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "reports", ["server_id"], :name => "index_reports_on_server_id"

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "base_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
