require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "subscription count" do
    assert Subscription.all.count == 3
  end
end
