require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  test "subscriber count" do
    assert Subscriber.all.count == 2
  end

  test "subscriber 1 has 2 subscriptions" do
    assert Subscriber.find(1).subscriptions.count == 2
  end


end
