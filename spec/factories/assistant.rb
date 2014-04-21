
FactoryGirl.define do
  factory :vip_card_order, class: Tips::VipCardOrder do
    provider
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
  end
end