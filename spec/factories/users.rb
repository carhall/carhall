FactoryGirl.define do 
  factory :user do
    mobile { Faker::PhoneNumber.cell_phone }
    password { 'password' }
    username { Faker::Name.name }
    description { Faker::Lorem.sentence }
    detail do
      {
        sex: Auth::UserDetail::Sexes.sample,
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
        dealer_type: Auth::DealerDetail::DealerTypes.sample,
        business_scopes: Auth::DealerDetail::BusinessScopes.sample(3),
      }
    end
  end
end