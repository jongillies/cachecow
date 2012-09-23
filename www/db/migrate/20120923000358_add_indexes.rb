class AddIndexes < ActiveRecord::Migration
  def up
    add_index :bulk_orders, :crop_id
    add_index :bulk_orders, :subscriber_id
    add_index :changes, :uuid
    add_index :changes, :harvester_uuid
    add_index :deliveries, :uuid
    add_index :deliveries, :transaction_uuid
    add_index :harvests, :uuid
    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, :crop_id
    add_index :transactions, :uuid
  end

  def down
    remove_index :bulk_orders, :crop_id
    remove_index :bulk_orders, :subscriber_id
    remove_index :changes, :uuid
    remove_index :changes, :harvester_uuid
    remove_index :deliveries, :uuid
    remove_index :deliveries, :transaction_uuid
    remove_index :harvests, :uuid
    remove_index :subscriptions, :subscriber_id
    remove_index :subscriptions, :crop_id
    remove_index :transactions, :uuid
  end
end
