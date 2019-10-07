require 'rails_helper'
require 'rake'

describe 'categorize restaurant' do
  it "categorizes restaurants and populates category field" do
    Rails.application.load_tasks
    ls1_small = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 9)
    ls1_medium = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 13)
    ls1_large = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 120)
    ls2_small = create(:restaurant, postal_code: "LS2 JCL", number_of_chairs: 11)
    ls2_large = create(:restaurant, postal_code: "LS2 JCL", number_of_chairs: 200)

    expect(ls1_small.category).to eq(nil)
    expect(ls1_medium.category).to eq(nil)
    expect(ls1_large.category).to eq(nil)
    expect(ls2_small.category).to eq(nil)
    expect(ls2_large.category).to eq(nil)

    Rake::Task['restaurants:categorize'].invoke

    expect(Restaurant.find(ls1_small.id).category).to eq("ls1 small")
    expect(Restaurant.find(ls1_medium.id).category).to eq("ls1 medium")
    expect(Restaurant.find(ls1_large.id).category).to eq("ls1 large")
    expect(Restaurant.find(ls2_small.id).category).to eq("ls2 small")
    expect(Restaurant.find(ls2_large.id).category).to eq("ls2 large")
  end
end

describe 'categorize restaurant' do
  it "categorizes restaurants and populates category field" do
    Rails.application.load_tasks
    ls1_small = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 9)
    ls1_medium = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 13)
    ls1_large = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 120)
    ls2_small = create(:restaurant, postal_code: "LS2 JCL", number_of_chairs: 11)
    ls2_large = create(:restaurant, postal_code: "LS2 JCL", number_of_chairs: 200)

    Rake::Task['restaurants:categorize'].invoke

    Rake::Task['restaurants:export_small_restaurants'].invoke
    Rake::Task['restaurants:concat_category_to_name'].invoke

    expect(Restaurant.find_by(id: ls1_small.id)).to eq(nil)
    expect(Restaurant.find(ls1_medium.id).category).to eq("ls1 medium")
    expect(Restaurant.find(ls1_large.id).category).to eq("ls1 large")
    expect(Restaurant.find(ls2_small.id).category).to eq("ls2 small")
    expect(Restaurant.find(ls2_large.id).category).to eq("ls2 large")
  end
end
