class TransactionLog < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :crop
  has_one :change_log, :foreign_key => :crop_change_uuid, :primary_key => :crop_change_uuid
  has_one :delivery_log, :primary_key => :delivery_log_uuid, :foreign_key => :delivery_log_uuid
end
