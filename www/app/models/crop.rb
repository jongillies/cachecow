class Crop < ActiveRecord::Base
  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions
  has_many :change_logs
  has_many :harvester_logs, :foreign_key => :harvester_uuid
end
