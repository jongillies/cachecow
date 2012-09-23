

YAML::load_file("test/fixtures/crops.yml").each do |_,crop|
  Crop.create(crop)
end

YAML::load_file("test/fixtures/subscribers.yml").each do |_,subscriber|
  Subscriber.create(subscriber)
end

YAML::load_file("test/fixtures/subscriptions.yml").each do |_,subscription|
  Subscription.create(subscription)
end


