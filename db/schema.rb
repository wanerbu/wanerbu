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

ActiveRecord::Schema.define(:version => 20131226094257) do

  create_table "activities", :force => true do |t|
    t.string   "name",              :limit => 50,  :default => "",   :null => false
    t.string   "source_type"
    t.integer  "user_id",                                            :null => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "signup_start_time"
    t.datetime "signup_end_time"
    t.integer  "court_id"
    t.string   "activity_address",  :limit => 100, :default => "",   :null => false
    t.integer  "limit_num"
    t.string   "contact_name"
    t.string   "contact_telephone", :limit => 30,  :default => "",   :null => false
    t.string   "qq"
    t.text     "details"
    t.string   "status",                           :default => "00", :null => false
    t.float    "activity_cost"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "activities", ["court_id"], :name => "index_activities_on_court_id"

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

  create_table "areas", :force => true do |t|
    t.integer  "city_id"
    t.string   "area",       :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "cities", :force => true do |t|
    t.integer  "province_id"
    t.string   "city",        :limit => 20
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

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

  create_table "game_price_rules", :force => true do |t|
    t.integer  "game_id"
    t.string   "rule_type",  :limit => 2, :default => "00", :null => false
    t.integer  "week_value", :limit => 1
    t.date     "date_value"
    t.time     "start_time"
    t.time     "end_time"
    t.float    "price"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "game_price_rules", ["game_id"], :name => "index_game_price_rules_on_game_id"

  create_table "game_reservation_rules", :force => true do |t|
    t.integer  "game_id"
    t.string   "rule_type",       :limit => 2, :default => "00", :null => false
    t.integer  "week_value",      :limit => 1
    t.date     "date_value"
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "can_reservation"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "game_reservation_rules", ["game_id"], :name => "index_game_reservation_rules_on_game_id"

  create_table "games", :force => true do |t|
    t.integer  "court_id"
    t.string   "name",            :limit => 20
    t.integer  "sort",            :limit => 3
    t.boolean  "can_reservation"
    t.float    "default_price",                 :default => 0.0
    t.integer  "max_people",      :limit => 5
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "games", ["court_id"], :name => "index_games_on_court_id"

  create_table "gym_comments", :force => true do |t|
    t.integer  "gym_id"
    t.integer  "user_id"
    t.float    "score",      :default => 0.0, :null => false
    t.text     "comment"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "gym_images", :force => true do |t|
    t.integer  "gym_id"
    t.string   "image"
    t.string   "intro",      :limit => 2
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "gym_images", ["gym_id"], :name => "index_gym_images_on_gym_id"

  create_table "gyms", :force => true do |t|
    t.string   "name",        :limit => 50,  :default => "",   :null => false
    t.integer  "user_id",                                      :null => false
    t.text     "intro",                                        :null => false
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "area_id"
    t.string   "address",     :limit => 100, :default => "",   :null => false
    t.string   "telephone",   :limit => 30,  :default => "",   :null => false
    t.time     "open_time",                                    :null => false
    t.time     "close_time",                                   :null => false
    t.string   "status",                     :default => "00", :null => false
    t.string   "reason",      :limit => 100
    t.text     "history_log"
    t.string   "logo"
    t.datetime "deleted_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "gyms", ["user_id"], :name => "index_gyms_on_user_id", :unique => true

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "status",                     :default => "00", :null => false
    t.string   "telephone_no", :limit => 30, :default => "",   :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "properties", :force => true do |t|
    t.string   "name",       :limit => 20, :null => false
    t.string   "unit",       :limit => 6
    t.string   "intro",      :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "properties", ["name"], :name => "index_properties_on_name", :unique => true

  create_table "provinces", :force => true do |t|
    t.string   "province",   :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "game_id"
    t.integer  "order_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.float    "price"
    t.integer  "people_num", :limit => 3
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "rich_rich_files", :force => true do |t|
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        :default => "file"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",           :limit => 20,                 :null => false
    t.integer  "sort",           :limit => 3,   :default => 1, :null => false
    t.string   "function_codes", :limit => 300
    t.datetime "deleted_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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

  create_table "user_activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "join_num"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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
