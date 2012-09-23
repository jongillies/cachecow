class TransactionLog < ActiveRecord::Base
  has_one :subscriber, :foreign_key => :id, :primary_key => :id
  has_one :crop
  has_one :change_log, :foreign_key => :crop_change_uuid, :primary_key => :crop_change_uuid
  has_one :delivery_log, :primary_key => :delivery_log_uuid, :foreign_key => :delivery_log_uuid


  attr_accessible(
      :queue_time,
      :crop_change_uuid,
      :delivery_log_uuid,
      :subscriber_id,
      :transaction_uuid
  )
end
