class Statistic::UserInfo < ActiveRecord::Base
  include Share::Dealerable

  has_many :sales_case, primary_key: :mobile, foreign_key: :user_mobile
  
  validates_presence_of :user_plate_num, :project, :adviser
end