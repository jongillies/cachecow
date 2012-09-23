require 'test_helper'

class CropTest < ActiveSupport::TestCase

  test "crop count" do
    assert Crop.all.count == 2
  end

  # Traverse the object path from the crop
  test "crop 400 has 2 subscriptions" do
    assert Crop.find_by_crop_number(400).subscriptions.count == 2
  end

  test "crop 400 has 2 changes" do
    assert Crop.find_by_crop_number(400).changes.count == 2
  end

  test "crop 400 has 1 harvest" do
    assert Crop.find_by_crop_number(400).harvests.count == 1
  end

  test "crop 500 has 1 subscription" do
    assert Crop.find_by_crop_number(500).subscriptions.count == 1
  end

end
