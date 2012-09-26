require 'test_helper'

class DeliveryTest < ActiveSupport::TestCase

  test "delivery count" do
    assert Delivery.all.count == 3
  end

  test "1st has a transaction" do
    assert Delivery.find(1).transaction.id == 1
  end


end
