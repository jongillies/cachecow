require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  test "subscriber count" do
    assert Subscriber.all.count == 2
  end

end
