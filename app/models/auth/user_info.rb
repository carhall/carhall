module Auth
  class UserInfo < ActiveRecord::Base
    include Share::Areable
    include Share::Brandable

    has_attached_file :reg_img, styles: { medium: "300x300>", thumb: "100x100>" }
    belongs_to :source, class_name: 'User'
    alias_attribute :user, :source

    attr_accessible :source
    attr_accessible :sex, :area_id, :brand_id, :area, :brand,
      :series, :plate_num, :reg_img

    def serializable_hash(options={})
      options = { 
        only: [:sex, :series, :plate_num, :balance],
        methods: [:reg_img, :area, :brand]
      }.update(options)
      super(options)
    end

  end
end