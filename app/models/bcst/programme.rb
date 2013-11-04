class Bcst::Programme < ActiveRecord::Base
  include Share::Providerable

  has_many :comments, as: :source, class_name: 'Bcst::Comment'
  has_and_belongs_to_many :hosts

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :provider
  validates_presence_of :title

  def to_without_host_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :description
      json.image! self, :avatar
    end
  end

  def to_base_builder
    json = to_without_host_builder
    json.hosts hosts.map{|h|h.to_without_programme_builder.attributes!}
    json
  end

  def to_detail_builder
    json = to_base_builder
    json.comments comments.includes(:user, :at_user).map{|c|c.to_base_builder.attributes!}
    json
  end
  
end
