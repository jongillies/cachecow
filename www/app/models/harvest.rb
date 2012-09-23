class Harvest < ActiveRecord::Base

  belongs_to :crop, :foreign_key => :crop_number, :primary_key => :crop_number
  has_many :changes, :foreign_key => :uuid, :primary_key => :uuid

  before_save :calculate_duration

  attr_accessible(:id,
                  :crop_number,
                  :began_at,
                  :ended_at,
                  :total_records,
                  :number_of_changes,
                  :number_of_adds,
                  :number_of_deletes,
                  :uuid)

  validates_presence_of(:id,
                        :crop_number,
                        :began_at,
                        :ended_at,
                        :total_records,
                        :number_of_changes,
                        :number_of_adds,
                        :number_of_deletes,
                        :uuid)

  def calculate_duration
    self.duration = self.ended_at - self.began_at
  end

  def total_change_set
    number_of_adds + number_of_changes + number_of_deletes
  end
end
