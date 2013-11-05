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

  factory :mending, class: Tips::Mending do
    dealer
  end

  factory :cleaning, class: Tips::Cleaning do
    title { Faker::Lorem.sentence }
    cleaning_type { Tips::Cleaning::CleaningType.names.first }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :activity, class: Tips::Activity do
    title { Faker::Lorem.sentence }
    expire_at { rand_time(1.months.since, 3.months.since) }
    dealer
  end

  factory :bulk_purchasing, class: Tips::BulkPurchasing do
    title { Faker::Lorem.sentence }
    bulk_purchasing_type { Tips::BulkPurchasing::BulkPurchasingType.names.sample }
    expire_at { rand_time(1.months.since, 3.months.since) }
    price { rand(100) }
    vip_price { rand(100) }
    dealer
  end

  factory :mending_order, class: Tips::MendingOrder do
    detail do
      {
        brand: Category::Brand.names.sample, 
        series: Faker::Lorem.word, 
        plate_num: generate(:plate_num),
        mending_type: Tips::MendingOrderDetail::MendingType.names.sample,
        arrive_at: rand_time(3.months.ago, 3.months.since),
      }
    end
    association :source, factory: :mending
    user
  end

  factory :cleaning_order, class: Tips::CleaningOrder do
    count { rand(9)+1 }
    association :source, factory: :cleaning
    user
  end

  factory :bulk_purchasing_order, class: Tips::BulkPurchasingOrder do
    count { rand(9)+1 }
    association :source, factory: :bulk_purchasing
    user
  end

  factory :review, class: Tips::Review do
    content { Faker::Lorem.sentence }
    stars { rand(5)+1 }
    association :order, factory: :mending_order
  end
end
