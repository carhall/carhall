class Statistic::SalesCase < ActiveRecord::Base
  include Share::Userable
  include Share::Dealerable

  before_save do
    self.user_mobile = user.mobile
    self.user_plate_num = user.plate_num
  end
  
  validates_presence_of :description, :solution, :provider
end