# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mending do
    dealer
  end

  factory :cleaning do
    title { Faker::Lorem.sentence }
    cleaning_type { Cleaning::CleaningTypes.sample }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :activity do
    title { Faker::Lorem.sentence }
    expire_at { Time.now }
    dealer
  end

  factory :bulk_purchasing do
    title { Faker::Lorem.sentence }
    bulk_purchasing_type { BulkPurchasing::BulkPurchasingTypes.sample }
    expire_at { Time.now }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :mending_order do
    detail do
      {
        brand_id: Share::Brandable::Brands.sample, 
        series: Faker::Lorem.sentence, 
        plate_num: Faker::Lorem.sentence,
        arrive_at: Time.now,
      }
    end
    user
  end

  factory :cleaning_order do
    detail do
      {
        count: rand(10),
      }
    end
    user
  end

  factory :bulk_purchasing_order do
    detail do
      {
        count: rand(10),
      }
    end
    user
  end
end
