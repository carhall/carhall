class Bcst::ProgrammeList < ActiveRecord::Base
  include Share::Providerable

  validates_presence_of :provider
  validates_presence_of :title, :airdate, :day
  validates_numericality_of :day, greater_than_or_equal_to: 0, less_than_or_equal_to: 6, allow_nil: true

  acts_as_api

  api_accessible :base do |t|
    t.only :title, :airdate, :description
  end

end
