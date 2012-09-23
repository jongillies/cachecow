#
# TransactionLog records are added via the JSON post to the controller
#
# Inbound parameters are:
#
# data['queue_time']
# data['subscription_id']
# data['crop_change_uuid']
# data['transaction_uuid']
#

class TransactionLog < ActiveRecord::Base

  belongs_to :subscription
  has_one :change_log, :foreign_key => :crop_change_uuid, :primary_key => :crop_change_uuid
  has_one :delivery_log, :primary_key => :delivery_log_uuid, :foreign_key => :delivery_log_uuid

  attr_accessible(
      :subscription_id,
      :crop_change_uuid,
      :transaction_uuid,
      :queue_time
  )
end
