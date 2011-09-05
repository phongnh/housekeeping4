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

ActiveRecord::Schema.define(:version => 20110721000000) do

  create_table "account_types", :force => true do |t|
    t.string "name"
  end

  add_index "account_types", ["name"], :name => "index_account_types_on_name", :unique => true

  create_table "accounts", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "account_type_id"
    t.string   "name"
    t.boolean  "default",         :default => false
    t.string   "description"
    t.integer  "income",          :default => 0
    t.integer  "expense",         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["account_type_id"], :name => "index_accounts_on_account_type_id"
  add_index "accounts", ["name"], :name => "index_accounts_on_name"
  add_index "accounts", ["owner_id", "name"], :name => "index_accounts_on_owner_id_and_name", :unique => true
  add_index "accounts", ["owner_id"], :name => "index_accounts_on_owner_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "color",      :default => "white"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "transaction_types", :force => true do |t|
    t.string "name"
  end

  add_index "transaction_types", ["name"], :name => "index_transaction_types_on_name", :unique => true

  create_table "transactions", :force => true do |t|
    t.date     "date"
    t.integer  "year",        :limit => 2
    t.integer  "month",       :limit => 1
    t.integer  "day",         :limit => 1
    t.integer  "account_id"
    t.integer  "category_id"
    t.integer  "reporter_id"
    t.integer  "payee_id"
    t.integer  "amount"
    t.string   "description"
    t.integer  "kind"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["account_id"], :name => "index_transactions_on_account_id"
  add_index "transactions", ["category_id"], :name => "index_transactions_on_category_id"
  add_index "transactions", ["date"], :name => "index_transactions_on_date"
  add_index "transactions", ["day"], :name => "index_transactions_on_day"
  add_index "transactions", ["kind"], :name => "index_transactions_on_kind"
  add_index "transactions", ["month"], :name => "index_transactions_on_month"
  add_index "transactions", ["payee_id"], :name => "index_transactions_on_payee_id"
  add_index "transactions", ["reporter_id"], :name => "index_transactions_on_reporter_id"
  add_index "transactions", ["year", "month", "day"], :name => "index_transactions_on_year_and_month_and_day"
  add_index "transactions", ["year", "month"], :name => "index_transactions_on_year_and_month"
  add_index "transactions", ["year"], :name => "index_transactions_on_year"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender",                                :default => 0
    t.datetime "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
