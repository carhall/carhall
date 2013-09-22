class Accounts::UserDetail < ActiveRecord::Base
  include Share::Areable
  include Share::Brandable

  extend Share::ImageAttachments
  define_image_method
  alias_attribute :car_image, :image
  
  attr_accessible :sex_id, :area_id, :brand_id, :series, :plate_num, :car_image
  attr_accessible :sex, :area, :brand

  extend Share::Id2Key
  Sexes = %w(男 女)
  define_id2key_methods :sex

  def serializable_hash(options={})
    options = { 
      only: [:sex_id, :area_id, :brand_id, :series, :plate_num, :balance],
      methods: [:sex, :area, :brand],
      images: [:car_image],
    }.update(options)
    super(options)
  end

end
