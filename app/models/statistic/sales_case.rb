class Statistic::SalesCase < ActiveRecord::Base
  include Share::Userable
  include Share::Dealerable
  include Share::UserInfoable

  enumerate :state, with: %w(跟踪 解决 取消)

  before_save do
    if user
      self.user_mobile ||= user.mobile
      self.user_plate_num ||= user.plate_num
    end
  end
  
  validates_presence_of :description, :solution, :adviser
  
  include Share::Queryable
  define_queryable_column :user_mobile, :user_plate_num

end