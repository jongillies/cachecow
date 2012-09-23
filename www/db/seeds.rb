

YAML::load_file("test/fixtures/crops.yml").each do |_,crop|
  Crop.create(crop)
end

YAML::load_file("test/fixtures/subscribers.yml").each do |_,subscriber|
  Subscriber.create!(subscriber)
end

YAML::load_file("test/fixtures/subscriptions.yml").each do |_,subscription|
  Subscription.create!(subscription)
end

YAML::load_file("test/fixtures/harvester_logs.yml").each do |_,harvester_log|
  HarvesterLog.create!(harvester_log)
end

YAML::load_file("test/fixtures/change_logs.yml").each do |_,change_log|
  ChangeLog.create!(change_log)
end

YAML::load_file("test/fixtures/transaction_logs.yml").each do |_,transaction_log|
  TransactionLog.create!(transaction_log)
end

YAML::load_file("test/fixtures/delivery_logs.yml").each do |_,delivery_log|
  DeliveryLog.create!(delivery_log)
end
