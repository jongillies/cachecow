class Subscriber < ActiveRecord::Base

  attr_accessible(
      :name,
      :secret_key,
      :admin_contact,
      :technical_contact,
  )

  has_many :subscriptions
  has_many :crops, :through => :subscriptions

  validates_presence_of :name, :secret_key, :admin_contact, :technical_contact

end
