# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c1 = Crop.create!(
    name: "Password File",
    description: "/etc/passwd",
    crop_number: 400,
    config_options: "",
    active: true,
    delay_interval: 0,
)

c2 = Crop.create!(
    name: "Dictionary",
    description: "My Dictionary File",
    crop_number: 500,
    config_options: "",
    active: true,
    delay_interval: 0,
)


s1 = Subscriber.create!(
    name: "Security Police",
    secret_key: "You will never guess my secret key",
    admin_contact: "security@company.com",
    technical_contact: "security@company.com"
)

s2 = Subscriber.create!(
    name: "Dictionary Dog",
    secret_key: "woof",
    admin_contact: "dict@company.com",
    technical_contact: "dict@company.com"
)


sub1 = Subscription.create!(
    crop_id: c1.id,
    subscriber_id: s1.id,
    tractor_quantity: 0,
    endpoint_url: "http://localhost:3456",
    active: true
    )

sub2 = Subscription.create!(
    crop_id: c2.id,
    subscriber_id: s1.id,
    tractor_quantity: 0,
    endpoint_url: "http://localhost:3456",
    active: true
)

sub1 = Subscription.create!(
    crop_id: c1.id,
    subscriber_id: s2.id,
    tractor_quantity: 0,
    endpoint_url: "http://localhost:3456",
    active: true
)





