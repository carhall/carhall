module Auth
  class ProviderDetail < ActiveRecord::Base    
    attr_accessible :company, :phone

    validates_presence_of :company, :phone
    
    # Fake attributes
    attr_accessor :dealer_type_id, :business_scope_ids, :address, :open_during, :reg_img
    attr_accessible :dealer_type_id, :business_scope_ids, :address, :open_during, :reg_img

    def serializable_hash(options={})
      options = { 
        only: [:company, :phone],
        # methods: [:reg_img],
      }.update(options)
      super(options)
    end

  end
end