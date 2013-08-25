module Auth
  class DealerInfo < ActiveRecord::Base
    has_attached_file :reg_img, styles: { medium: "300x300>", thumb: "100x100>" }
    belongs_to :source, class_name: 'Dealer'
    alias_attribute :user, :source
    alias_attribute :dealer, :source

    attr_accessible :source
    attr_accessible :dealer_type, :company, :address, 
      :phone, :open, :accepted, :reg_img

    def serializable_hash(options={})
      options = { 
        only: [:dealer_type, :company, :address, 
          :phone, :open, :accepted, :balance],
        methods: [:reg_img]
      }.update(options)
      super(options)
    end

  end
end