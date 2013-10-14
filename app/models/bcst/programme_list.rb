class Bcst::ProgrammeList < ActiveRecord::Base
  include Share::Providerable

  validates_presence_of :provider
  validates_presence_of :title, :airdate, :day

  acts_as_api

  api_accessible :base do |t|
    t.only :title, :airdate, :description
  end

end
