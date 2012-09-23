class Crop < ActiveRecord::Base

  attr_accessible(
      :name,
      :description,
      :crop_number,
      :config_options,
      :active,
      :delay_interval,
  )

  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions
  has_many :change_logs
  has_many :harvester_logs

  validates_presence_of :name, :crop_number, :description
  validates_numericality_of :crop_number, :in => 0..1000
  validates_uniqueness_of :name, :crop_number
end
