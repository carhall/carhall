module Share::Dealerable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :dealer, class_name: 'Accounts::Dealer'
    scope :with_dealer, ->(u) { where dealer_id: u }
  end

end
