

YAML::load_file("test/fixtures/crops.yml").each do |_,crop|
  puts Crop.create(crop)
end

YAML::load_file("test/fixtures/subscribers.yml").each do |_,subscriber|
  puts Subscriber.create(subscriber)
end

YAML::load_file("test/fixtures/subscriptions.yml").each do |_,subscription|
  puts Subscription.create(subscription)
end

YAML::load_file("test/fixtures/harvests.yml").each do |_,harvest|
  puts Harvest.create(harvest)
end

YAML::load_file("test/fixtures/changes.yml").each do |_,change|
  puts Change.create(change)
end

YAML::load_file("test/fixtures/transactions.yml").each do |_,transaction|
  puts Transaction.create(transaction)
end

YAML::load_file("test/fixtures/deliveries.yml").each do |_,delivery|
  puts Delivery.create(delivery)
end
