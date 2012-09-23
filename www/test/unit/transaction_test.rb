require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "transaction count" do
    assert Transaction.all.count == 3
  end

  test "1st transaction has a subscription" do
    assert Transaction.find(1).subscription.id == 1
  end

  test "1st transaction has a delivery" do
    assert Transaction.find(1).delivery.id == 1
  end

  test "1st transaction has a change" do
    assert Transaction.find(1).change.id == 1
  end

end
