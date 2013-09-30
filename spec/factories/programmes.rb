# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :programme do
    provider nil
    title "MyString"
    avatar ""
    host nil
    description "MyText"
  end
end
