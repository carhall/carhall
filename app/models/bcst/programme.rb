class Bcst::Programme < ActiveRecord::Base
  belongs_to :provider, class_name: 'Accounts::Provider'

  has_and_belongs_to_many :hosts

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :title

  has_many :comments, as: :source, class_name: 'Bcst::Comment'

end
