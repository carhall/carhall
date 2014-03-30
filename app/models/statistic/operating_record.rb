class Statistic::OperatingRecord < ActiveRecord::Base
  include Share::Dealerable

  belongs_to :user_info, primary_key: :plate_num, foreign_key: :user_plate_num
  include Share::UserInfoable

  validates_presence_of :user_plate_num, :project, :adviser

  default_scope { order('id DESC') }

end