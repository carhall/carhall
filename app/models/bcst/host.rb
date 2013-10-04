class Bcst::Host < ActiveRecord::Base
  include Share::Providerable

  has_and_belongs_to_many :programmes

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :provider
  validates_presence_of :name

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :name, :description
    t.images :avatar
  end

  api_accessible :detail, extend: :base do |t|
    t.add :programmes, template: :base
  end

end
