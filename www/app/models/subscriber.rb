class Subscriber < ActiveRecord::Base

  attr_accessible(
      :name,
      :secret_key,
      :admin_contact,
      :technical_contact,
      :subscriber_number
  )

  has_many :subscriptions
  has_many :crops, :through => :subscriptions

end
