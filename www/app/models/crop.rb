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
  has_many :changes, :foreign_key => :crop_number, :primary_key => :crop_number
  has_many :harvests, :foreign_key => :crop_number, :primary_key => :crop_number

  validates_presence_of :name, :crop_number, :description
  validates_numericality_of :crop_number, :in => 0..1000
  validates_uniqueness_of :name, :crop_number

  def number_of_things(transaction_type)
    self.changes.where(:crop_number => self.crop_number, :transaction_type => transaction_type).count
  end

  def harvests
    Harvest.where(:crop_number => self.crop_number).count
  end

  def total_records
    unless CropLog.where(:crop_id => self.id).order(:ended_at).last.nil?
      CropLog.where(:crop_id => self.id).order(:ended_at).last.total_records
    else
      0
    end
  end

end
