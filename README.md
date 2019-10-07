# README

## Getting Started

In order to run street cafes app, you need to have the following installed:
  1) Postgres (9.4+)
  2) Rails(4.2+)

## Build/Setup
``` bundle install ```
``` rake db:{drop,create,migrate,seed} ```
``` rake restaurants:categorize ``` to populate restaurant.category column

## SQL Views
There are two sql (db) views:
  1) post_codes view
  2) categories view
These two sql views each have migrations and associated models to allow these table to function just like a standard table would in rails. Commands like: PostCode.all, PostCode.total_chairs, Category.total_places, Category.total_chairs, etc.

### Categories View

```
class CreatePostalCodesView < ActiveRecord::Migration[5.2]
  def up
    self.connection.execute %Q( CREATE OR REPLACE VIEW post_codes AS
      SELECT
          r.postal_code AS post_code,
          COUNT(*) AS total_places,
          SUM(r.number_of_chairs) AS total_chairs,
          TRUNC(((SUM(r.number_of_chairs) / ((SELECT SUM(number_of_chairs::decimal) FROM restaurants) - SUM(r.number_of_chairs::decimal))) * 100), 2) AS chairs_pct,
          (SELECT name FROM restaurants rr WHERE r.postal_code = rr.postal_code AND MAX(r.number_of_chairs) = rr.number_of_chairs) AS place_with_max_chairs,
          MAX(r.number_of_chairs) AS max_chairs
        FROM restaurants r
        GROUP BY r.postal_code;)
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS post_codes;"
  end
end
```
#### Category Model
```
class Category < ApplicationRecord
end
```

#### Categories View Results
![Categories View Results](/app/assets/images/categories_view.jpg)

### PostCodes View
```
class CreatePostalCodesView < ActiveRecord::Migration[5.2]
  def up
    self.connection.execute %Q( CREATE OR REPLACE VIEW post_codes AS
      SELECT
          r.postal_code AS post_code,
          COUNT(*) AS total_places,
          SUM(r.number_of_chairs) AS total_chairs,
          TRUNC(((SUM(r.number_of_chairs) / ((SELECT SUM(number_of_chairs::decimal) FROM restaurants) - SUM(r.number_of_chairs::decimal))) * 100), 2) AS chairs_pct,
          (SELECT name FROM restaurants rr WHERE r.postal_code = rr.postal_code AND MAX(r.number_of_chairs) = rr.number_of_chairs) AS place_with_max_chairs,
          MAX(r.number_of_chairs) AS max_chairs
        FROM restaurants r
        GROUP BY r.postal_code;)
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS post_codes;"
  end
end

```
#### PostCode Model
```
class PostCode < ApplicationRecord
end
```

#### PostCode View Results
![Post Code View Results](/app/assets/images/post_codes_view.jpg)

## Tasks
There are three rake tasks under the restaurant namespace:
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

Each can be run by simply running `rake restaurants:categorize` etc.
