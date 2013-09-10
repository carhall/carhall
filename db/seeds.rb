# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


me = User.where(mobile: '13112345678', username: 'user').first_or_initialize
me.password = 'password' && me.save! if me.new_record?

3.times do 
  u = FactoryGirl.create :user
  me.make_friend_with! u
end

10.times do
  FactoryGirl.create :post, user: me.friends.sample
end

30.times do
  FactoryGirl.create :comment, source: Post.all.sample, user: User.all.sample
end