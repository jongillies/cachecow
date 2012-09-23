class DeliveryLog < ActiveRecord::Base
  has_one :transaction_log, :primary_key => :transaction_uuid, :foreign_key => :transaction_uuid
end
