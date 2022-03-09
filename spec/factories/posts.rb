FactoryBot.define do
  factory :post do
    association :user
    association :hotspring

    accesibility { rand(-3..3) }
    gas_risk { rand(-3..3) }
    water_tempreature { rand(-3..3) }
  end
end
