require 'support/factory_bot'
FactoryBot.define do
  factory :restaurant do
    name { "John's Eats" }
    street_address {"40West EatMoreBeMore Ave"}
    postal_code {"blah"}
    number_of_chairs {10}
  end
end
