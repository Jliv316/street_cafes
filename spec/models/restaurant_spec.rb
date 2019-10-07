require 'rails_helper'

describe Restaurant, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:postal_code)}
    it {should validate_presence_of(:number_of_chairs)}
  end

  describe 'class methods' do
    before(:each) do

    end
    describe '.' do
      it 'should ' do

      end
    end

    describe '.' do
      it 'should ' do

      end
    end

    describe '.' do
      it 'should' do
      end
    end
  end
end
