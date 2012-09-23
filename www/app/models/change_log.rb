class ChangeLog < ActiveRecord::Base
  belongs_to :crop
  belongs_to :harvester_log, :foreign_key => :harvester_uuid, :primary_key => :harvester_uuid
  has_many :transaction_logs, :foreign_key => :crop_change_uuid, :primary_key => :crop_change_uuid
end
