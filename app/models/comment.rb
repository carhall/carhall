class Comment < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :source, polymorphic: true
  belongs_to :at_user

  # attr_accessible :content
  # attr_accessible :user, :source, :at_user
  # attr_accessible :source, :at_user_id

  validates_presence_of :user
  validates_presence_of :content
  
  acts_as_api

  api_accessible :base do |t|
    t.only :id, :content
    t.methods :user, :at_user
    t.add :user, template: :base
    t.add :at_user, template: :base
  end

end
