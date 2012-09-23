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
end
