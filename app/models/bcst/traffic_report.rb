class Bcst::TrafficReport < ActiveRecord::Base
  include Share::Userable
  include Share::Providerable
  
  has_many :comments, as: :source, class_name: 'Bcst::Comment'
  belongs_to :at_user, class_name: 'Accounts::User'

  validates_presence_of :user, :provider
  validates_presence_of :content

  extend Share::ImageAttachments
  define_image_method
  
  default_scope { order('id DESC') }
  
  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :content, :created_at, :latitude, :longitude
      json.image! self, :image
      json.builder! self, :user, :base
      json.builder! self, :at_user, :base
    end
  end
  
end