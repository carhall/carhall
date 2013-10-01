# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post, class: Posts::Post do
    content { Faker::Lorem.paragraph }
    user
  end

  factory :comment, class: Posts::Comment do
    content { Faker::Lorem.sentence }
    association :source, factory: :post
    user
  end

  factory :club, class: Posts::Club do
    announcement { Faker::Lorem.sentence }
  end
end
