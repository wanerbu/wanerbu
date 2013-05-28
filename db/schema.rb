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

ActiveRecord::Schema.define(:version => 20130501024936) do

  create_table "admin_roles", :force => true do |t|
    t.integer "admin_id", :null => false
    t.integer "role_id",  :null => false
  end

  add_index "admin_roles", ["admin_id"], :name => "index_admin_roles_on_admin_id"
  add_index "admin_roles", ["role_id"], :name => "index_admin_roles_on_role_id"

  create_table "admins", :force => true do |t|
    t.string   "login_id",               :limit => 16
    t.string   "first_name",             :limit => 10
    t.string   "last_name",              :limit => 10
    t.string   "telephone_no",           :limit => 15
    t.string   "status",                 :limit => 2
    t.datetime "deleted_at"
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "admins", ["authentication_token"], :name => "index_admins_on_authentication_token", :unique => true
  add_index "admins", ["confirmation_token"], :name => "index_admins_on_confirmation_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["login_id"], :name => "index_admins_on_login_id", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "court_properties", :force => true do |t|
    t.integer  "court_id"
    t.integer  "property_id"
    t.string   "property_value", :limit => 20
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "court_properties", ["court_id", "property_id"], :name => "index_court_properties_on_court_id_and_property_id", :unique => true

  create_table "courts", :force => true do |t|
    t.integer  "sport_id",                           :null => false
    t.integer  "gym_id",                             :null => false
    t.string   "reservation_type", :default => "00", :null => false
    t.float    "min_unit",         :default => 0.5
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "courts", ["sport_id", "gym_id", "reservation_type"], :name => "index_courts_on_sport_id_and_gym_id_and_reservation_type", :unique => true

  create_table "games", :force => true do |t|
    t.integer  "court_id"
    t.string   "name",            :limit => 20
    t.integer  "sort",            :limit => 3
    t.boolean  "can_reservation"
    t.float    "default_price",                 :default => 0.0
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "games", ["court_id"], :name => "index_games_on_court_id"

  create_table "gyms", :force => true do |t|
    t.string   "name",        :limit => 50,  :default => "",   :null => false
    t.integer  "user_id",                                      :null => false
    t.text     "intro",                                        :null => false
    t.string   "address",     :limit => 100, :default => "",   :null => false
    t.string   "telephone",   :limit => 30,  :default => "",   :null => false
    t.time     "open_time",                                    :null => false
    t.time     "close_time",                                   :null => false
    t.float    "score",                      :default => 0.0,  :null => false
    t.string   "status",                     :default => "00", :null => false
    t.string   "reason",      :limit => 100
    t.text     "history_log"
    t.datetime "deleted_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "gyms", ["user_id"], :name => "index_gyms_on_user_id", :unique => true

  create_table "properties", :force => true do |t|
    t.string   "name",       :limit => 20, :null => false
    t.string   "unit",       :limit => 6
    t.string   "intro",      :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "properties", ["name"], :name => "index_properties_on_name", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name",           :limit => 20,                 :null => false
    t.integer  "sort",           :limit => 3,   :default => 1, :null => false
    t.string   "function_codes", :limit => 300
    t.datetime "deleted_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "sport_properties", :force => true do |t|
    t.integer  "sport_id"
    t.integer  "property_id"
    t.string   "default_value", :limit => 20
    t.integer  "scope",         :limit => 9
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "sport_properties", ["sport_id", "property_id"], :name => "index_sport_properties_on_sport_id_and_property_id", :unique => true

  create_table "sports", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.text     "intro"
    t.integer  "sort",       :limit => 3
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "sports", ["name"], :name => "index_sports_on_name", :unique => true

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["role_id"], :name => "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login_id",               :limit => 16
    t.string   "first_name",             :limit => 10
    t.string   "last_name",              :limit => 10
    t.string   "honey_name",             :limit => 20
    t.string   "telephone_no",           :limit => 15
    t.boolean  "sex"
    t.date     "birthday"
    t.string   "address",                :limit => 200
    t.string   "status",                 :limit => 2
    t.datetime "deleted_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",                    :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
