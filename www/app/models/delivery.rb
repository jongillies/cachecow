#
# DeliveryLog records are added via the JSON post to the controller
#
# Inbound parameters are:
#
# data['queue_time']
# data['uuid']
# data['transaction_uuid']
# data['endpoint_response_code']
# data['endpoint_response_header']
# data['endpoint_response_data']
# data['endpoint_response_date']
#

class Delivery < ActiveRecord::Base
  has_one :transaction, :primary_key => :transaction_uuid, :foreign_key => :uuid

  attr_accessible :queue_time,
                  :transaction_uuid,
                  :uuid,
                  :endpoint_response_code,
                  :endpoint_response_data,
                  :endpoint_response_header,
                  :endpoint_response_date

end
