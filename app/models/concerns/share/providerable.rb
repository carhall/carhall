module Share::Providerable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :provider, class_name: 'Accounts::Provider'
    scope :with_provider, ->(u) { where provider_id: u }
  end

end
