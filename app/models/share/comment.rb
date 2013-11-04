class Share::Comment < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :source, polymorphic: true
  belongs_to :at_user, class_name: 'Accounts::User'

  validates_presence_of :user, :source
  validates_presence_of :content
  
  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :content, :created_at
      json.builder! self, :user, :base
      json.builder! self, :at_user, :base
    end
  end

end
