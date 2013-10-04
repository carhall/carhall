module Share::Dealerable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :dealer, class_name: 'Accounts::Dealer'
    scope :with_dealer, ->(u) { where dealer_id: Share::Dealerable.get_id(u) }
  end

  def self.get_id dealer
    if dealer.kind_of? Accounts::Dealer then dealer.id else dealer end
  end

end
