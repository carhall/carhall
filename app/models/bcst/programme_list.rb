class Bcst::ProgrammeList < ActiveRecord::Base
  belongs_to :provider, class_name: 'Accounts::Provider'

  validates_presence_of :title, :airdate, :day
  validates_numericality_of :day, greater_than_or_equal_to: 0, less_than_or_equal_to: 6, allow_nil: true

end
