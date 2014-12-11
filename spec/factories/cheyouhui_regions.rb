# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cheyouhui_region, :class => 'Cheyouhui::Region' do
    name "MyString"
    status 1
  end
end
