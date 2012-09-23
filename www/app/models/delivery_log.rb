#
# DeliveryLog records are added via the JSON post to the controller
#
# Inbound parameters are:
#
# data['queue_time'] = queued_at
# data['delivery_log_uuid'] = delivery_uuid
# data['transaction_uuid'] = transaction_uuid
# data['endpoint_response_code'] = endpoint_response_code
# data['endpoint_response_header'] = endpoint_response_header
# data['endpoint_response_data'] = endpoint_response_data
# data['endpoint_response_date'] = endpoint_response_date
#

class DeliveryLog < ActiveRecord::Base
  has_one :transaction_log, :primary_key => :transaction_uuid, :foreign_key => :transaction_uuid

  attr_accessible :queue_time,
                  :transaction_uuid,
                  :delivery_log_uuid,
                  :endpoint_response_code,
                  :endpoint_response_data,
                  :endpoint_response_header,
                  :endpoint_response_date

end
