class Bcst::Host < ActiveRecord::Base
  include Share::Providerable

  has_and_belongs_to_many :programmes

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :provider
  validates_presence_of :name

  def to_without_programme_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :name, :description
      json.image! self, :avatar
    end
  end

  def to_base_builder
    json = to_without_programme_builder
    json.programmes programmes.map{|h|h.to_without_host_builder.attributes!}
    json
  end

  def to_detail_builder
    to_base_builder
  end

end
