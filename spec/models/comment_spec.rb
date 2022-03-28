require 'rails_helper'

RSpec.describe 'Comment Model Test', type: :model do
  describe 'Validation check' do
    let(:user) { create(:user) }
    let(:hotspring) { create(:hotspring) }
    context 'validations,' do
      it 'has validation' do
        comment = build(:comment, user_id: user.id, hotspring_id: hotspring.id)
        comment.valid?
      end
      it 'is invalid without hotspring' do
        comment = build(:comment, user_id: user.id)
        expect(comment).not_to be_valid
      end
      it 'is invalid without user' do
        comment = build(:comment, hotspring_id: hotspring.id)
        expect(comment).not_to be_valid
      end
      it 'is invalid without comment' do
        comment = build(:comment, comment: '', user_id: user.id, hotspring_id: hotspring.id)
        expect(comment).not_to be_valid
      end
    end
  end
end
