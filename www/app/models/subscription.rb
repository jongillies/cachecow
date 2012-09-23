class Subscription < ActiveRecord::Base

  attr_accessible(
      :crop_id,
      :subscriber_id,
      :tractor_quantity,
      :created_at,
      :updated_at,
      :endpoint_url,
      :active
  )

  belongs_to :crop
  belongs_to :subscriber

  validates_presence_of :crop_id, :subscriber_id, :tractor_quantity
  validates_presence_of :endpoint_url, message: "can't be blank since we need to send the data there."
  validates :tractor_quantity, :numericality => true

end
