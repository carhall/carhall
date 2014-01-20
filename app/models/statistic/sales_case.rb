class Statistic::SalesCase < ActiveRecord::Base
  include Share::Userable
  include Share::Dealerable

  validates_presence_of :description, :solution, :provider
end