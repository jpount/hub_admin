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

ActiveRecord::Schema.define(version: 20140130183600) do

  create_table "api_metrics", force: true do |t|
    t.integer  "api_id"
    t.integer  "total_count"
    t.integer  "success_count"
    t.integer  "error_count"
    t.integer  "last_entry_tps"
    t.integer  "last_exit_tps"
    t.integer  "max_entry_tps"
    t.integer  "max_exit_tps"
    t.string   "ip"
    t.string   "msg_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_metrics", ["ip"], name: "index_apimetrics_on_ip", using: :btree
  add_index "api_metrics", ["msg_name"], name: "index_apimetrics_on_name", using: :btree

  create_table "apis", force: true do |t|
    t.integer  "api_id"
    t.datetime "last_ping"
    t.string   "url"
    t.string   "alt_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.string   "api_type",     default: "IN"
  end

  add_index "apis", ["api_id"], name: "index_api_on_id", using: :btree
  add_index "apis", ["display_name"], name: "index_api_on_display_name", using: :btree
  add_index "apis", ["url"], name: "index_api_on_url", using: :btree

  create_table "confs", force: true do |t|
    t.integer  "ping_interval"
    t.string   "nimbus_url"
    t.string   "cassandra_url"
    t.integer  "fi_port"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ganglia_url"
    t.string   "ganglia_host"
    t.boolean  "show_lb",              default: false
    t.integer  "dashboard_refresh_ms", default: 5000
  end

  create_table "dashboards", force: true do |t|
    t.string  "name"
    t.string  "time"
    t.string  "layout"
    t.boolean "locked", default: false
  end

  create_table "fis", force: true do |t|
    t.datetime "last_ping"
    t.string   "url"
    t.string   "alt_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.string   "fi_type",      default: "SENDER"
    t.string   "fi_org",       default: "CBA"
    t.boolean  "ignore",       default: false
  end

  add_index "fis", ["display_name"], name: "index_fi_on_display_name", using: :btree
  add_index "fis", ["id"], name: "index_fi_on_id", using: :btree
  add_index "fis", ["url"], name: "index_fi_on_url", using: :btree

  create_table "load_balancers", force: true do |t|
    t.integer  "conf_id"
    t.string   "display_name"
    t.string   "user_name",    default: "opsworks"
    t.string   "password",     default: "password0"
    t.string   "proxy_type",   default: "FRONTEND"
    t.string   "proxy_name",   default: "application"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metrics", force: true do |t|
    t.integer  "fi_id"
    t.integer  "total_count"
    t.integer  "success_count"
    t.integer  "error_count"
    t.integer  "last_entry_tps"
    t.integer  "last_exit_tps"
    t.integer  "max_entry_tps"
    t.integer  "max_exit_tps"
    t.string   "ip"
    t.string   "msg_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "metrics", ["ip"], name: "index_metrics_on_ip", using: :btree
  add_index "metrics", ["msg_name"], name: "index_metrics_on_name", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "widgets", force: true do |t|
    t.string  "name"
    t.string  "kind"
    t.string  "source"
    t.text    "settings"
    t.integer "dashboard_id"
    t.integer "update_interval"
    t.integer "col"
    t.integer "row"
    t.integer "size_x"
    t.integer "size_y"
  end

end
