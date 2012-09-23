class Subscriber < ActiveRecord::Base
  has_many :subscriptions
  has_many :crops, :through => :subscriptions
end
