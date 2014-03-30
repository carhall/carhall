class Statistic::SalesCase < ActiveRecord::Base
  include Share::Userable
  include Share::Dealerable

  belongs_to :user_info, primary_key: :mobile, foreign_key: :user_mobile
  include Share::UserInfoable

  enumerate :state, with: %w(跟踪 解决 取消)

  before_save do
    if user_info
      self.user_plate_num = user_info.plate_num
    elsif user
      self.user_mobile = user.mobile
      self.user_plate_num = user.plate_num
    elsif user_mobile
      self.user = Accounts::User.find_by(mobile: user_mobile)
      self.user_plate_num = user.plate_num if user
    end
  end
  
  validates_presence_of :description, :solution, :adviser
  
  include Share::Queryable
  define_queryable_column :user_mobile, :user_plate_num

end