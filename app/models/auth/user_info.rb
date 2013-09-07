module Auth
  class UserInfo < ActiveRecord::Base
    include Share::Areable
    include Share::Brandable

    has_attached_file :reg_img, styles: { medium: "300x200>", thumb: "60x60>" }
    
    # belongs_to :source, class_name: 'User'
    # alias_attribute :user, :source

    # attr_accessible :source
    attr_accessible :sex, :area_id, :brand_id, :series, :plate_num, :reg_img
    attr_accessible :area, :brand

    def serializable_hash(options={})
      options = { 
        only: [:sex, :area_id, :brand_id, :series, :plate_num, :balance],
        methods: [:area, :brand],
        images: [:reg_img],
      }.update(options)
      super(options)
    end

  end
end