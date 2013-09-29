# Read about factories at https://github.com/thoughtbot/factory_girl

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

FactoryGirl.define do
  sequence :plate_num do |n|
    "京#{('A'..'G').to_a.sample}#{"%05d" % rand(100000)}"
  end

  factory :mending do
    dealer
  end

  factory :cleaning do
    title { Faker::Lorem.sentence }
    cleaning_type { Cleaning::CleaningTypes.names.sample }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :activity do
    title { Faker::Lorem.sentence }
    expire_at { rand_time(3.months.ago, 3.months.since) }
    dealer
  end

  factory :bulk_purchasing do
    title { Faker::Lorem.sentence }
    bulk_purchasing_type { BulkPurchasing::BulkPurchasingTypes.names.sample }
    expire_at { rand_time(3.months.ago, 3.months.since) }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :mending_order do
    detail do
      {
        brand_id: [0,1,2,3].sample, 
        series: Faker::Lorem.word, 
        plate_num: generate(:plate_num),
        mending_type: Tips::MendingOrderDetail::MendingTypes.names.sample,
        arrive_at: rand_time(3.months.ago, 3.months.since),
      }
    end
    association :source, factory: :mending
    user
  end

  factory :cleaning_order do
    detail do
      {
        count: rand(9)+1,
      }
    end
    association :source, factory: :cleaning
    user
  end

  factory :bulk_purchasing_order do
    detail do
      {
        count: rand(9)+1,
      }
    end
    association :source, factory: :bulk_purchasing
    user
  end

  factory :review do
    content { Faker::Lorem.sentence }
    stars { rand(5) }
    association :order, factory: :mending_order
  end
end
