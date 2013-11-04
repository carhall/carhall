class Accounts::UserDetail < ActiveRecord::Base
  extend Share::ImageAttachments
  define_image_method
  alias_attribute :car_image, :image

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :series, :plate_num, :balance
      json.image! self, :car_image
    end
  end

end
