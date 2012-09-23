class HarvesterLog < ActiveRecord::Base

  belongs_to :crop
  has_many :change_logs, :foreign_key => :change_log_uuid, :primary_key => :change_log_uuid

  before_save :calculate_duration

  attr_accessible(:id,
                  :crop_number,
                  :began_at,
                  :ended_at,
                  :total_records,
                  :number_of_changes,
                  :number_of_adds,
                  :number_of_deletes,
                  :harvester_uuid)

  validates_presence_of(:id,
                        :crop_number,
                        :began_at,
                        :ended_at,
                        :total_records,
                        :number_of_changes,
                        :number_of_adds,
                        :number_of_deletes,
                        :harvester_uuid)

  def calculate_duration
    self.duration = self.ended_at - self.began_at
  end

end
