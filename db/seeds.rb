# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

me = Account.where(mobile: '13112345678').first
me ||= FactoryGirl.create :user, mobile: '13112345678'

dealer = Account.where(mobile: '13212345678').first
dealer ||= FactoryGirl.create :dealer, mobile: '13212345678'

3.times do 
  u = FactoryGirl.create :user
  me.make_friend_with! u
end

10.times do
  FactoryGirl.create :post, user: me.friends.sample
end

30.times do
  FactoryGirl.create :comment, post: Post.all.sample, user: User.all.sample
end

100.times do
  u = FactoryGirl.create :user
  u.make_friend_with! dealer
end

mending = FactoryGirl.create :mending, dealer: dealer
5.times do
  mending_order = FactoryGirl.create :mending_order,
    user: dealer.inverse_friends.sample, source: mending
  FactoryGirl.create :review, order: mending_order
end

5.times do
  cleaning = FactoryGirl.create :cleaning, dealer: dealer
  5.times do
    cleaning_order = FactoryGirl.create :cleaning_order, 
      user: dealer.inverse_friends.sample, source: cleaning
    FactoryGirl.create :review, order: cleaning_order
  end

  activity = FactoryGirl.create :activity, dealer: dealer

  bulk_purchasing = FactoryGirl.create :bulk_purchasing, dealer: dealer
  5.times do
    bulk_purchasing_order = FactoryGirl.create :bulk_purchasing_order, 
      user: dealer.inverse_friends.sample, source: bulk_purchasing
    FactoryGirl.create :review, order: bulk_purchasing_order
  end
end