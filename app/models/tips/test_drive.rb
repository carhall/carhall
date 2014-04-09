class Tips::TestDrive < ActiveRecord::Base
  include Tips::Servicable
  set_order_class Tips::TestDriveOrder

  extend Share::ImageAttachments
  define_image2_method
  
  validates_presence_of :dealer
  validates_presence_of :title, :price, :phone

end
