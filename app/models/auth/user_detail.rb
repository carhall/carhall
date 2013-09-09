module Auth
  class UserDetail < ActiveRecord::Base
    include Share::Areable
    include Share::Brandable

    has_attached_file :reg_img, styles: { medium: "300x200>", thumb: "60x60>" }
    
    # alias_attribute :user, :source

    # attr_accessible :source
    attr_accessible :sex_id, :area_id, :brand_id, :series, :plate_num, :reg_img
    attr_accessible :sex, :area, :brand

    extend Share::Id2Key
    Sexes = %w(男 女)
    define_id2key_methods :sex

    def posts_count user
      user.posts.count
    end

    def last_n_posts user, n = 3
      user.posts.last(n)
    end

    def serializable_hash(options={})
      options = { 
        only: [:sex, :area_id, :brand_id, :series, :plate_num, :balance],
        methods: [:area, :brand],
        images: [:reg_img],
      }.update(options)
      super(options).merge(
        posts_count: posts_count(options[:source]), 
        last_3_posts: last_n_posts(options[:source])
      )
    end

  end
end