class Crop < ActiveRecord::Base

  attr_accessible(
      :name,
      :description,
      :crop_number,
      :config_options,
      :active,
      :delay_interval,
      :crop_number
  )

  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions
  has_many :change_logs
  has_many :harvester_logs, :foreign_key => :harvester_uuid

end
