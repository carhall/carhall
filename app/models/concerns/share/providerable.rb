module Share::Providerable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :provider, class_name: 'Accounts::Provider'
    scope :with_provider, ->(u) { where provider_id: Share::Providerable.get_id(u) }
  end

  def self.get_id provider
    if provider.kind_of? Accounts::Provider then provider.id else provider end
  end

end
