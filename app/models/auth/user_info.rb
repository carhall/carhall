module Auth
  class UserInfo < ActiveRecord::Base
    include Share::Areable
    include Share::Brandable

    extend Share::ImageFile
    define_image_methods :reg_img
    
    belongs_to :source, class_name: 'User'
    alias_attribute :user, :source

    attr_accessible :source
    attr_accessible :sex, :area_id, :brand_id, :series, :plate_num, :reg_img
    attr_accessible :area, :brand

    def serializable_hash(options={})
      options = { 
        only: [:sex, :area_id, :brand_id, :series, :plate_num, :balance],
        methods: [:reg_img_thumb_url, :reg_img_url, :area, :brand]
      }.update(options)
      super(options)
    end

  end
end