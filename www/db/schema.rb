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

ActiveRecord::Schema.define(:version => 20120923000358) do

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

end
