

YAML::load_file("test/fixtures/crops.yml").each do |_,crop|
  Crop.create(crop)
end

YAML::load_file("test/fixtures/subscribers.yml").each do |_,subscriber|
  Subscriber.create!(subscriber)
end

YAML::load_file("test/fixtures/subscriptions.yml").each do |_,subscription|
  Subscription.create!(subscription)
end

YAML::load_file("test/fixtures/harvests.yml").each do |_,harvest|
  Harvest.create!(harvest)
end

YAML::load_file("test/fixtures/changes.yml").each do |_,change|
  Change.create(change)
end

YAML::load_file("test/fixtures/transactions.yml").each do |_,transaction|
  Transaction.create!(transaction)
end

YAML::load_file("test/fixtures/deliveries.yml").each do |_,delivery|
  Delivery.create!(delivery)
end
