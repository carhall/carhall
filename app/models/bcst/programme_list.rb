class Bcst::ProgrammeList < ActiveRecord::Base
  include Share::Providerable

  validates_presence_of :provider
  validates_presence_of :title, :airdate, :day

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :title, :airdate, :description
    end
  end
  
end
