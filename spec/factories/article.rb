FactoryBot.define do
  factory :article do
    association :user
    association :hotspring
    url { 'https://google.com' }
  end
end
