class Share::OpenDatabaseStruct < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :source, polymorphic: true
  
end