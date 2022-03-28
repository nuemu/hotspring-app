require 'rails_helper'

RSpec.describe 'Favorite Model Test', type: :model do
  describe 'Validation check' do
    context 'validations,' do
      it 'has validation' do
        favorite = build(:favorite)
        favorite.valid?
      end
      it 'is invalid with multiple entry' do
        user = create(:user)
        hotspring = create(:hotspring)
        favorite1 = create(:favorite, user_id: user.id, hotspring_id: hotspring.id)
        favorite2 = build(:favorite, user_id: user.id, hotspring_id: hotspring.id)
        expect(favorite2).not_to be_valid
      end
    end
  end
end
