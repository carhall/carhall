module Share::Distributorable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :distributor, class_name: 'Accounts::Distributor'
    scope :with_distributor, ->(u) { where distributor_id: u }
  end

end
