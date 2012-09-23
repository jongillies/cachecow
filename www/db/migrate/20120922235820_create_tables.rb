class CreateTables < ActiveRecord::Migration
  def up
    create_table :bulk_orders do |t|
      t.integer :crop_id
      t.integer :subscriber_id
      t.string :command
      t.string :results
      t.timestamps
    end

    create_table :change_logs, :force => true do |t|
      t.integer :crop_id
      t.datetime :queue_time
      t.string :primary_key
      t.text :previous_value, :limit => 2147483647
      t.text :current_value, :limit => 2147483647
      t.string :transaction_type
      t.string :crop_change_uuid
      t.string :harvester_uuid
      t.timestamps
    end

    create_table :crops, :force => true do |t|
      t.string :name
      t.text :description
      t.integer :crop_number
      t.text :config_options
      t.boolean :active
      t.integer :delay_interval
      t.timestamps
    end

    create_table :delivery_logs, :force => true do |t|
      t.string :transaction_uuid
      t.integer :endpoint_response_code
      t.string :endpoint_response_header
      t.string :endpoint_response_data
      t.datetime :endpoint_response_date
      t.string :delivery_log_uuid
      t.datetime :queue_time
      t.timestamps
    end

    create_table :harvester_logs, :force => true do |t|
      t.integer :crop_id
      t.datetime :began_at
      t.datetime :ended_at
      t.integer :total_records
      t.integer :number_of_changes
      t.integer :number_of_adds
      t.integer :number_of_deletes
      t.integer :subscriber_id
      t.string :harvester_uuid
      t.integer :duration
      t.timestamps
    end

    create_table :subscribers, :force => true do |t|
      t.string :name
      t.string :secret_key
      t.string :admin_contact
      t.string :technical_contact
      t.integer :subscriber_number
      t.timestamps
    end

    create_table :subscriptions, :force => true do |t|
      t.integer :crop_id
      t.integer :subscriber_id
      t.integer :tractor_quantity, :default => 1
      t.string :endpoint_url
      t.boolean :active
      t.timestamps
    end

    create_table :transaction_logs, :force => true do |t|
      t.integer :crop_id
      t.integer :subscriber_id
      t.string :queue_time
      t.string :primary_key
      t.text :previous_value, :limit => 2147483647
      t.text :current_value, :limit => 2147483647
      t.string :transaction_type
      t.string :crop_change_uuid
      t.string :transaction_uuid
      t.timestamps
    end

  end

  def down
    drop_table :bulk_orders
    drop_table :change_logs
    drop_table :crops
    drop_table :delivery_logs
    drop_table :harvester_logs
    drop_table :subscribers
    drop_table :subscriptions
    drop_table :transaction_logs
  end
end