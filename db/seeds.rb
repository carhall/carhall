# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def factory model, times = 1, &args
  times.times do
    obj = model.create args.call
    puts obj.errors.full_messages if obj.errors
  end
end

factory User, 100 do
  {
    mobile: Faker::PhoneNumber.cell_phone,
    password: 'password',
    username: Faker::Name.name,
    description: Faker::Lorem.sentence,
    detail: {
      sex: ['男', '女'].sample,
      area: Share::Areable::Areas.sample,
      brand: Share::Brandable::Brands.sample,
    }
  }
end

factory Dealer, 10 do
  {
    mobile: Faker::PhoneNumber.cell_phone,
    password: 'password',
    username: Faker::Name.name,
    description: Faker::Lorem.sentence,
    detail: {
      dealer_type: ['洗车美容', '专项服务', '专修', '4S店'].sample,
      company: Faker::Name.name+'有限公司',
      address: Faker::Address.state+' '+Faker::Address.city+' '+Faker::Address.street_name,
      phone: Faker::PhoneNumber.phone_number,
      accepted: [true, false].sample,
    }
  }
end

factory Provider, 5 do
  {
    mobile: Faker::PhoneNumber.cell_phone,
    password: 'password',
    username: Faker::Name.name,
    description: Faker::Lorem.sentence,
    detail: {
      company: Faker::Name.name+'有限公司',
    }
  }
end