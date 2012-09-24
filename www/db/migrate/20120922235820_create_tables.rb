class CreateTables < ActiveRecord::Migration
  def up
    create_table :bulk_orders do |t|
      t.string :uuid
      t.integer :crop_id
      t.integer :subscriber_id
      t.string :command
      t.string :results
      t.timestamps
    end

    create_table :changes, :force => true do |t|
      t.integer :crop_number
      t.datetime :queue_time
      t.string :primary_key
      t.text :previous_value, :limit => 2147483647
      t.text :current_value, :limit => 2147483647
      t.string :transaction_type
      t.string :uuid
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

    create_table :deliveries, :force => true do |t|
      t.string :transaction_uuid
      t.integer :endpoint_response_code
      t.string :endpoint_response_header
      t.string :endpoint_response_data
      t.datetime :endpoint_response_date
      t.string :uuid
      t.datetime :queue_time
      t.timestamps
    end

    create_table :harvests, :force => true do |t|
      t.integer :crop_number
      t.datetime :began_at
      t.datetime :ended_at
      t.integer :total_records
      t.integer :number_of_changes
      t.integer :number_of_adds
      t.integer :number_of_deletes
      t.string :uuid
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
      t.integer :subscriber_id
      t.integer :crop_id
      t.integer :tractor_quantity, :default => 1
      t.string :endpoint_url
      t.boolean :active
      t.timestamps
    end

    create_table :transactions, :force => true do |t|
      t.string :change_uuid
      t.string :queue_time
      t.string :uuid
      t.integer :subscription_id
      t.timestamps
    end

  end

  def down
    drop_table :bulk_orders
    drop_table :changes
    drop_table :crops
    drop_table :deliveries
    drop_table :harvests
    drop_table :subscribers
    drop_table :subscriptions
    drop_table :transactions
  end
end