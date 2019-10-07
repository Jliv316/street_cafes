namespace :restaurants do
  desc "categorize restaurants based on chair count"

  task categorize: :environment do
    puts "Populating restaurants with category tags based on number_of_chairs"

    Restaurant.find_all_ls1_small.update_all(category: "ls1 small")
    Restaurant.find_all_ls1_medium.update_all(category: "ls1 medium")
    Restaurant.find_all_ls1_large.update_all(category: "ls1 large")
    Restaurant.find_all_ls2_small.update_all(category: "ls1 small")
    Restaurant.find_all_ls2_large.update_all(category: "ls1 large")
    Restaurant.find_all_other.update_all(category: "other")
  end
end
