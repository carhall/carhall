class Accounts::ProviderDetail < ActiveRecord::Base    
  attr_accessible :company, :phone

  validates_presence_of :company, :phone
  
  # Fake attributes
  attr_accessor :dealer_type_id, :business_scope_ids, :address, :open_during, :authentication_image
  attr_accessible :dealer_type_id, :business_scope_ids, :address, :open_during, :authentication_image

  def serializable_hash(options={})
    options = { 
      only: [:company, :phone],
    }.update(options)
    super(options)
  end

end
