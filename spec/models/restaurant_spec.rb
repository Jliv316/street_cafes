require 'rails_helper'

describe Restaurant, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:postal_code)}
    it {should validate_presence_of(:number_of_chairs)}
  end

  describe 'class methods' do
    describe 'all ls1 mthods' do
      it 'should grab the correct restaurant records based on number of chairs ' do
        ls1_small = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 9)
        ls1_medium = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 13)
        ls1_large = create(:restaurant, postal_code: "LS1 JCL", number_of_chairs: 120)
        ls2_small = create(:restaurant, postal_code: "LS2 JCL", number_of_chairs: 11)
        ls2_large = create(:restaurant, postal_code: "LS2 JCL", number_of_chairs: 200)


        expect(Restaurant.find_all_ls1_small.first.number_of_chairs).to eq(9)
        expect(Restaurant.find_all_ls1_medium.first.number_of_chairs).to eq(13)
        expect(Restaurant.find_all_ls1_large.first.number_of_chairs).to eq(120)
        expect(Restaurant.find_all_ls2_small.first.number_of_chairs).to eq(11)
        expect(Restaurant.find_all_ls2_large.first.number_of_chairs).to eq(200)
      end
    end

    describe 'all ls2 records' do
      it 'should grab the correct restaurant records based on number of chairs' do

      end
    end

    describe 'all other records' do
      it 'should grab the correct restaurant records based on number of chair' do

      end
    end
  end
end
