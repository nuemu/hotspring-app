require 'rails_helper'

RSpec.describe 'User Model Test', type: :model do
  describe 'Validation check' do
    context 'validations,' do
      it 'has validation' do
        user = build(:user)
        user.valid?
      end
      it 'is invalid with empty name' do
        user = build(:user, name: '')
        expect(user).not_to be_valid
      end
    end
  end
end
