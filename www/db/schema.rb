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

ActiveRecord::Schema.define(:version => 20120926043552) do

  create_table "bulk_orders", :force => true do |t|
    t.string   "uuid"
    t.integer  "crop_id"
    t.integer  "subscriber_id"
    t.string   "command"
    t.string   "results"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "bulk_orders", ["crop_id"], :name => "index_bulk_orders_on_crop_id"
  add_index "bulk_orders", ["subscriber_id"], :name => "index_bulk_orders_on_subscriber_id"

  create_table "changes", :force => true do |t|
    t.integer  "crop_number"
    t.datetime "queue_time"
    t.string   "primary_key"
    t.text     "previous_value",   :limit => 2147483647
    t.text     "current_value",    :limit => 2147483647
    t.string   "transaction_type"
    t.string   "uuid"
    t.string   "harvester_uuid"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "changes", ["harvester_uuid"], :name => "index_changes_on_harvester_uuid"
  add_index "changes", ["uuid"], :name => "index_changes_on_uuid"

  create_table "crops", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "crop_number"
    t.text     "config_options"
    t.boolean  "active"
    t.integer  "delay_interval"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "deliveries", :force => true do |t|
    t.string   "transaction_uuid"
    t.integer  "endpoint_response_code"
    t.string   "endpoint_response_header"
    t.string   "endpoint_response_data"
    t.datetime "endpoint_response_date"
    t.string   "uuid"
    t.datetime "queue_time"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "deliveries", ["transaction_uuid"], :name => "index_deliveries_on_transaction_uuid"
  add_index "deliveries", ["uuid"], :name => "index_deliveries_on_uuid"

  create_table "harvests", :force => true do |t|
    t.integer  "crop_number"
    t.datetime "began_at"
    t.datetime "ended_at"
    t.integer  "total_records"
    t.integer  "number_of_changes"
    t.integer  "number_of_adds"
    t.integer  "number_of_deletes"
    t.string   "uuid"
    t.integer  "duration"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "harvests", ["uuid"], :name => "index_harvests_on_uuid"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "subscribers", :force => true do |t|
    t.string   "name"
    t.string   "secret_key"
    t.string   "admin_contact"
    t.string   "technical_contact"
    t.integer  "subscriber_number"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "crop_id"
    t.integer  "tractor_quantity", :default => 1
    t.string   "endpoint_url"
    t.boolean  "active"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "subscriptions", ["crop_id"], :name => "index_subscriptions_on_crop_id"
  add_index "subscriptions", ["subscriber_id"], :name => "index_subscriptions_on_subscriber_id"

  create_table "transactions", :force => true do |t|
    t.string   "change_uuid"
    t.string   "queue_time"
    t.string   "uuid"
    t.integer  "subscription_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "transactions", ["uuid"], :name => "index_transactions_on_uuid"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
