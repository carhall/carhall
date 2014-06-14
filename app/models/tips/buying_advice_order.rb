class Tips::BuyingAdviceOrder < ActiveRecord::Base
  include Share::Userable
  include Share::Dealerable

  belongs_to :buying_advice
  alias_attribute :source, :buying_advice

  validates_presence_of :dealer
  validates_presence_of :price, :adviser

  before_save do
    self.user_id = source.user_id
  end

end
