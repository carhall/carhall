class Bcst::Host < ActiveRecord::Base
  belongs_to :provider, class_name: 'Accounts::Provider'

  has_and_belongs_to_many :programmes

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :name

end
