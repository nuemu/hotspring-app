FactoryBot.define do
  factory :hotspring do
    sequence(:name, 'hotspring_1')
    latitude { rand(35.2..35.7) }
    longtitude { rand(138.6..138.8) }
    description { 'description' }

    status { 'open' }

    trait :unexplored do
      status { 'unexplored' }
    end

    trait :not_exist do
      status { 'not_exist' }
    end

    trait :prohibit do
      status { 'prohibit' }
    end
  end
end
