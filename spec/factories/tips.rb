# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mending, class: Tips::Mending do
    dealer
  end

  factory :cleaning, class: Tips::Cleaning do
    title { Faker::Lorem.sentence }
    cleaning_type { Tips::Cleaning::CleaningTypes.sample }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :activity, class: Tips::Activity do
    title { Faker::Lorem.sentence }
    expire_at { Time.now }
    dealer
  end

  factory :bulk_purchasing, class: Tips::BulkPurchasing do
    title { Faker::Lorem.sentence }
    bulk_purchasing_type { Tips::BulkPurchasing::BulkPurchasingTypes.sample }
    expire_at { Time.now }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :mending_order, class: Tips::MendingOrder do
    detail_attributes do
      {
        brand_id: Share::Brandable::Brands.sample, 
        series: Faker::Lorem.sentence, 
        plate_num: Faker::Lorem.sentence,
        arrive_at: Time.now,
      }
    end
    association :source, factory: :mending
    user
  end

  factory :cleaning_order, class: Tips::CleaningOrder do
    detail_attributes do
      {
        count: rand(9)+1,
      }
    end
    association :source, factory: :cleaning
    user
  end

  factory :bulk_purchasing_order, class: Tips::BulkPurchasingOrder do
    detail_attributes do
      {
        count: rand(9)+1,
      }
    end
    association :source, factory: :bulk_purchasing
    user
  end

  factory :review, class: Tips::Review do
    content { Faker::Lorem.sentence }
    stars { rand(5) }
    association :order, factory: :mending_order
  end
end
