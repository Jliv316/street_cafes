# README

## Getting Started

In order to run street cafes app, you need to have the following installed:
  1) Postgres (9.4+)
  2) Rails(4.2+)

## Build/Setup
``` bundle install ```
``` rake db:{drop,create,migrate,seed} ```

## SQL Views
There are two sql (db) views:
  1) post_codes view
  2) categories view
These two sql views each have migrations and associated models to allow these table to function just like a standard table would in rails. Commands like: PostCode.all, PostCode.total_chairs, Category.total_places, Category.total_chairs, etc.

## Tasks
There are three tasks under the restaurant namespace:
```
namespace :restaurants do
  desc "categorize restaurants based on chair count"

  task categorize: :environment do
    puts "Populating restaurants with category tags based on number_of_chairs"

    Restaurant.find_all_ls1_small.update_all(category: "ls1 small")
    Restaurant.find_all_ls1_medium.update_all(category: "ls1 medium")
    Restaurant.find_all_ls1_large.update_all(category: "ls1 large")
    Restaurant.find_all_ls2_small.update_all(category: "ls2 small")
    Restaurant.find_all_ls2_large.update_all(category: "ls2 large")
    Restaurant.find_all_other.update_all(category: "other")
  end

  task export_small_restaurants: :environment do
    Restaurant.find_all_small.to_csv("small_restaurants")
  end

  task concat_category_to_name: :environment do
    Restaurant.find_all_medium_large.update_all("name = CONCAT(category, ' ', name)")
  end
end
```
