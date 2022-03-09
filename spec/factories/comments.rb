FactoryBot.define do
  factory :comment do
    association :user
    association :hotspring

    comment { 'comment' }
  end
end
