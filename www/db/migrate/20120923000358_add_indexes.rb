class AddIndexes < ActiveRecord::Migration
  def up
    add_index :bulk_orders, :crop_id
    add_index :bulk_orders, :subscriber_id
    add_index :change_logs, :crop_change_uuid
    add_index :change_logs, :harvester_uuid
    add_index :delivery_logs, :delivery_log_uuid
    add_index :delivery_logs, :transaction_uuid
    add_index :harvester_logs, :harvester_uuid
    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, :crop_id
    add_index :transaction_logs, :transaction_uuid
  end

  def down
    remove_index :bulk_orders, :crop_id
    remove_index :bulk_orders, :subscriber_id
    remove_index :change_logs, :crop_change_uuid
    remove_index :change_logs, :harvester_uuid
    remove_index :delivery_logs, :delivery_log_uuid
    remove_index :delivery_logs, :transaction_uuid
    remove_index :harvester_logs, :harvester_uuid
    remove_index :subscriptions, :subscriber_id
    remove_index :subscriptions, :crop_id
    remove_index :transaction_logs, :transaction_uuid
  end
end
