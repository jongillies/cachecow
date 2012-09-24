require 'test_helper'

class ChangeTest < ActiveSupport::TestCase
  test "change count" do
    assert Change.all.count == 2
  end

  test "1st change points back to crop 400" do
    assert Change.find(1).crop.crop_number == 400
  end

  test "1st change points to the harvest 1" do
    assert Change.find(1).crop.id == 1
  end

  test "1st change has 2 transactions" do
    assert Change.find(1).transactions.count == 2
  end

  test "2nd change has 1 transactions" do
    assert Change.find(1).transactions.count == 2
  end


end
