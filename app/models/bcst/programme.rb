class Bcst::Programme < ActiveRecord::Base
  include Share::Providerable

  has_many :comments, as: :source, class_name: 'Bcst::Comment'
  has_and_belongs_to_many :hosts

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :provider
  validates_presence_of :title

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :title, :description
    t.images :avatar
  end

  api_accessible :detail, extend: :base do |t|
    t.add :hosts, template: :base
  end

end
