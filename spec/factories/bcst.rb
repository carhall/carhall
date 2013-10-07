# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :programme, class: Bcst::Programme do
    provider
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
  end

  factory :host, class: Bcst::Host do
    provider
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
  end

  factory :programme_list, class: Bcst::ProgrammeList do
    provider
    airdate { "#{rand(24)}:00 至 #{rand(24)}:00" }
    title { Faker::Name.name }
    description { Faker::Lorem.sentence }
    day { rand(6) }
  end

  factory :programme_comment, class: Bcst::Comment do
    content { Faker::Lorem.sentence }
    association :source, factory: :programme
    user
  end

  factory :exposure, class: Bcst::Exposure do
    content { Faker::Lorem.sentence }
    provider
    user
  end

  factory :traffic_report, class: Bcst::TrafficReport do
    content { Faker::Lorem.sentence }
    latitude { 40 }
    longitude { 116.3 }
    provider
    user
  end
end
