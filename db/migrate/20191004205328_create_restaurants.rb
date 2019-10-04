class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string "name"
      t.string "street_address"
      t.string "postal_code"
      t.integer "number_of_chairs"
      
      t.timestamps
    end
  end
end
