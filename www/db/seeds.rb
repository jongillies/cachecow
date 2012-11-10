# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'User', :email => 'user@example.com', :password => 'Welcome1', :password_confirmation => 'Welcome1'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Administrator', :email => 'admin@example.com', :password => 'Welcome1', :password_confirmation => 'Welcome1'
puts 'New user created: ' << user2.name
user2.add_role :admin

#YAML::load_file("test/fixtures/crops.yml").each do |_,crop|
#  puts Crop.create(crop)
#end
#
#YAML::load_file("test/fixtures/subscribers.yml").each do |_,subscriber|
#  puts Subscriber.create(subscriber)
#end
#
#YAML::load_file("test/fixtures/subscriptions.yml").each do |_,subscription|
#  puts Subscription.create(subscription)
#end
#
#YAML::load_file("test/fixtures/harvests.yml").each do |_,harvest|
#  puts Harvest.create(harvest)
#end
#
#YAML::load_file("test/fixtures/changes.yml").each do |_,change|
#  puts Change.create(change)
#end
#
#YAML::load_file("test/fixtures/transactions.yml").each do |_,transaction|
#  puts Transaction.create(transaction)
#end
#
#YAML::load_file("test/fixtures/deliveries.yml").each do |_,delivery|
#  puts Delivery.create(delivery)
#end
