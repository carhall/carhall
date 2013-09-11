FactoryGirl.define do 
  factory :user do
    mobile { Faker::PhoneNumber.cell_phone }
    password { 'password' }
    username { Faker::Name.name }
    description { Faker::Lorem.sentence }
    detail_attributes do
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
    detail_attributes do
      {
        company: Faker::Lorem.sentence,
        address: Faker::Lorem.sentence,
        phone: Faker::PhoneNumber.phone_number,
      }
    end
  end

  factory :dealer do
    mobile { Faker::PhoneNumber.cell_phone }
    password { 'password' }
    username { Faker::Name.name }
    description { Faker::Lorem.sentence }
    detail_attributes do
      {
        company: Faker::Lorem.sentence,
        address: Faker::Lorem.sentence,
        phone: Faker::PhoneNumber.phone_number,
        open_during: Faker::Lorem.sentence,
        dealer_type: Accounts::DealerDetail::DealerTypes.sample,
        business_scopes: Accounts::DealerDetail::BusinessScopes.sample(3),
        authentication_image: File.open("public/images/thumb/missing.png"),
      }
    end
  end
end