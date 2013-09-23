Address = ['搜狐网络大厦', '百度大厦', '北京航空航天大学']

FactoryGirl.define do 
  factory :user do
    mobile { Faker::PhoneNumber.cell_phone }
    password { 'password' }
    username { Faker::Name.name }
    description { Faker::Lorem.sentence }
    detail do
      {
        sex: Accounts::UserDetail::Sexes.sample,
        area: Share::Areable::Areas.sample,
        brand: Share::Brandable::Brands.sample,
      }
    end
  end

  factory :provider do
    mobile { Faker::PhoneNumber.cell_phone }
    password { 'password' }
    username { Faker::Name.name }
    description { Faker::Lorem.sentence }
    detail do
      {
        company: Faker::Lorem.sentence,
        phone: Faker::PhoneNumber.phone_number,
      }
    end
  end

  factory :dealer do
    mobile { Faker::PhoneNumber.cell_phone }
    password { 'password' }
    username { Faker::Name.name }
    description { Faker::Lorem.sentence }
    detail do
      {
        area: Share::Areable::Areas.sample,
        company: Faker::Lorem.sentence,
        address: Address.sample,
        phone: Faker::PhoneNumber.phone_number,
        open_during: Faker::Lorem.sentence,
        dealer_type: Accounts::DealerDetail::DealerTypes.sample,
        business_scopes: Accounts::DealerDetail::BusinessScopes.sample(3),
        authentication_image: File.open("public/images/thumb/missing.png"),
        location: create(:location),
      }
    end
  end

  factory :location, class: Share::Location do
    latitude { 40 }
    longitude { 116.3 }
  end
end