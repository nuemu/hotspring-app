require 'rails_helper'

RSpec.describe 'Hotspring Model Test', type: :model do
  describe 'Validation check' do
    context 'validations,' do
      it 'has validation' do
        hotspring = build(:hotspring, name:'')
        hotspring.valid?
      end
      it 'is invalid with empty latitude' do
        hotspring = build(:hotspring, latitude: '')
        expect(hotspring).not_to be_valid
      end
      it 'is invalid with empty longtitude' do
        hotspring = build(:hotspring, longtitude: '')
        expect(hotspring).not_to be_valid
      end
      it 'is valid with filled lan long' do
        hotspring = build(:hotspring, name: '')
        expect(hotspring).to be_valid
      end
    end
  end
end
