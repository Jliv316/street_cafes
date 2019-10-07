class Restaurant < ApplicationRecord
  validates_presence_of :name, :street_address, :postal_code, :number_of_chairs

  def self.find_all_ls1_small
    where("postal_code like ?", "%LS1 %").where("number_of_chairs < 10")
  end

  def self.find_all_ls1_medium
    where("postal_code like ?", "%LS1 %").where("number_of_chairs >= 10 AND number_of_chairs < 100")
  end

  def self.find_all_ls1_large
    where("postal_code like ?", "%LS1 %").where("number_of_chairs >= 100")
  end

  def self.find_all_ls2_small
    where("postal_code like ?", "%LS2 %").where("number_of_chairs < #{median}")
  end

  def self.find_all_ls2_large
    where("postal_code like ?", "%LS2 %").where("number_of_chairs >= #{median}")
  end

  def self.find_all_ls2
    where("postal_code like ?", "%LS2 %")
  end

  def self.find_all_ls1
    where("postal_code like ?", "%LS1 %")
  end

  def self.find_all_other
    where.not("postal_code like ?", "%LS1 %").where.not("postal_code like ?", "%LS2 %")
  end

  def self.median
    ls2_restaurants = find_all_ls2
    median_index = (ls2_restaurants.count / 2)
    ls2_restaurants.order(:number_of_chairs)
    .offset(median_index)
    .pluck(:number_of_chairs)[0]
  end
end
