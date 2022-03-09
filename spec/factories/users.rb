FactoryBot.define do
  factory :user do
    sequence(:name, 'user_1')
    password { 'password' }
  end
end
