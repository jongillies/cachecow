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
  belongs_to :change, :foreign_key => :change_uuid, :primary_key => :uuid
  has_one :delivery, :foreign_key => :transaction_uuid, :primary_key => :uuid

  attr_accessible(
      :subscription_id,
      :change_uuid,
      :delivery_uuid,
      :uuid,
      :queue_time
  )
end
