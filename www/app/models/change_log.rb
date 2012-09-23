class ChangeLog < ActiveRecord::Base
  belongs_to :crop
  has_one :harvester_log, :foreign_key => :harvester_uuid, :primary_key => :harvester_uuid
  has_many :transaction_logs, :foreign_key => :crop_change_uuid, :primary_key => :crop_change_uuid

  attr_accessible :id,
                  :crop_id,
                  :queue_time,
                  :primary_key,
                  :previous_value,
                  :current_value,
                  :transaction_type,
                  :crop_change_uuid,
                  :harvester_uuid

  validates_uniqueness_of :primary_key,
                          :crop_change_uuid,
                          :harvester_uuid

end
