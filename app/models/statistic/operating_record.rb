class Statistic::OperatingRecord < ActiveRecord::Base
  include Share::Dealerable

  validates_presence_of :user_plate_num, :project, :adviser

  default_scope { order('id DESC') }

end