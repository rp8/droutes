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

ActiveRecord::Schema.define(:version => 20110315214600) do

  create_table "customers", :force => true do |t|
    t.string   "name",       :limit => 50
    t.string   "address",    :limit => 100, :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                   :null => false
    t.string   "phone",      :limit => 15,  :null => false
  end

  add_index "customers", ["user_id", "phone"], :name => "customers_user_id_phone_unique", :unique => true
  add_index "customers", ["user_id"], :name => "user_id_idx"

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                                                                      :null => false
    t.integer  "customer_id",                                                                  :null => false
    t.string   "order_status", :limit => 10,                                :default => "NEW", :null => false
    t.decimal  "total",                      :precision => 10, :scale => 2,                    :null => false
    t.text     "instruction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "name"
    t.string   "address"
  end

  add_index "orders", ["customer_id"], :name => "orders_customer_idx"
  add_index "orders", ["user_id"], :name => "orders_user_idx"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",                                           :null => false
    t.string   "phone",              :limit => 15
    t.string   "address",            :limit => 100
    t.integer  "orders_per_page",                   :default => 10
    t.integer  "customers_per_page",                :default => 5
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",               :limit => 50
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
