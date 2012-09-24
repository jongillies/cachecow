
class Change < ActiveRecord::Base

  has_one :crop, :foreign_key => :crop_number, :primary_key => :crop_number
  belongs_to :harvest, :foreign_key => :harvester_uuid, :primary_key => :uuid
  has_many :transactions, :foreign_key => :change_uuid, :primary_key => :uuid

  #TODO has_many :transactions, :foreign_key => :uuid, :through => :transactions

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
