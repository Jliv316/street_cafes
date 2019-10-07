require 'support/factory_bot'
FactoryBot.define do
  factory :restaurant do
    name { "John's Eats" }
    street_address {"40West EatMoreBeMore Ave"}
    postal_code {"blah"}
    number_of_chairs {10}
  end
end


# If the Post Code is of the LS1 prefix type:
# # of chairs less than 10: category = 'ls1 small'
# # of chairs greater than or equal to 10, less than 100: category = 'ls1 medium'
# # of chairs greater than or equal to 100: category = 'ls1 large'
# If the Post Code is of the LS2 prefix type:
# # of chairs below the 50th percentile for ls2: category = 'ls2 small'
# # of chairs above the 50th percentile for ls2: category = 'ls2 large'
# For Post Code is something else:
# category = 'other'
