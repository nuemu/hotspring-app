FactoryBot.define do
  factory :post do
    association :user
    association :hotspring
  end
end
