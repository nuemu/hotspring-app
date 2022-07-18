require 'rails_helper'

RSpec.describe 'Hotspring Model Test,', type: :model do
  describe 'Validation check,' do
    context 'Normal,' do
      it 'has validation' do
        hotspring = build(:hotspring, name: '')
        hotspring.valid?
      end
      it 'is valid with filled lan long' do
        hotspring = build(:hotspring, name: '')
        expect(hotspring).to be_valid
      end
    end

    context 'Abormal,' do
      it 'is invalid with too close points' do
        hotspring = create(:hotspring, name: '')
        gap = 0.000000000001
        hotspring_close = build(:hotspring, latitude: hotspring.latitude + gap, longtitude: hotspring.longtitude)
        expect(hotspring_close).not_to be_valid
      end
    end
  end
end
