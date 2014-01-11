class Share::Upload < ActiveRecord::Base
  has_attached_file :file

end