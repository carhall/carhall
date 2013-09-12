class Share::OpenDatabaseStruct < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :source, polymorphic: true

  attr_accessible :content
  attr_accessible :user, :source

  validates_presence_of :content
  
end