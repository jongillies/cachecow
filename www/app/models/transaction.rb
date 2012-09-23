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

class Transaction < ActiveRecord::Base

  belongs_to :subscription
  belongs_to :change, :foreign_key => :crop_change_uuid, :primary_key => :crop_change_uuid
  belongs_to :delivery, :primary_key => :transaction_uuid, :foreign_key => :transaction_uuid

  attr_accessible(
      :subscription_id,
      :crop_change_uuid,
      :uuid,
      :queue_time
  )
end
