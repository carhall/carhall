# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.paragraph }
    user
  end

  factory :comment, class: CommentCounterCached do
    content { Faker::Lorem.sentence }
    association :source, factory: :post
    user
  end

  factory :club do
    announcement { Faker::Lorem.sentence }
  end
end
