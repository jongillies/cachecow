require 'test_helper'

class HarvestTest < ActiveSupport::TestCase
  test "harvest count" do
    assert Harvest.all.count == 1
  end

  test "1st harvest has crop 400" do
    assert Harvest.find(1).crop.crop_number == 400
  end

  test "1st harvest has 2 changes" do
    assert Harvest.find(1).changes.count == 2
  end

  test "1st harvest a total change set of 2" do
    assert Harvest.find(1).total_change_set == 2
  end

end
