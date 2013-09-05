module Auth
  class DealerInfo < ActiveRecord::Base    
    extend Share::ImageFile
    define_image_methods :reg_img
    
    belongs_to :source, class_name: 'Dealer'
    alias_attribute :user, :source
    alias_attribute :dealer, :source

    attr_accessible :source
    attr_accessible :dealer_type_id, :business_scope_ids, :company, 
      :address, :phone, :open, :accepted, :reg_img
    attr_accessible :dealer_type, :business_scopes 

    extend Share::Id2Key

    DealerTypes = %w(洗车美容 专项服务 专修 4S店)
    define_id2key_methods :dealer_type

    BusinessScopes = %w(洗车 美容 轮胎 换油 改装 钣喷 空调 专修 保险)
    define_ids2keys_methods :business_scopes

    def serializable_hash(options={})
      options = { 
        only: [:dealer_type_id, :business_scope_ids, :company, :address, 
          :phone, :open],
        methods: [:dealer_type, :business_scopes],
      }.update(options)
      super(options)
    end

  end
end