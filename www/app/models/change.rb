#
# Change records are added via the JSON post to the controller
#
# Inbound parameters are:
#
# data['harvester_uuid']
# data['crop_number']
# data['queue_time']
# data['primary_key']
# data['previous_value']
# data['current_value']
# data['crop_change_uuid']
# data['transaction_type']
#

class Change < ActiveRecord::Base

  has_one :crop, :foreign_key => :crop_number, :primary_key => :crop_number
  has_one :harvester_log, :foreign_key => :harvester_uuid, :primary_key => :harvester_uuid
  has_many :transaction_logs, :foreign_key => :crop_change_uuid, :primary_key => :crop_change_uuid

  attr_accessible :id,
                  :crop_number,
                  :queue_time,
                  :primary_key,
                  :previous_value,
                  :current_value,
                  :transaction_type,
                  :uuid,
                  :harvester_uuid

end
