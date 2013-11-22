class Share::Comment < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :source, polymorphic: true
  belongs_to :at_user, class_name: 'Accounts::User'

  validates_presence_of :user, :source
  validates_presence_of :content
  
  before_save do
    self.user_username ||= user.username
    self.at_user_username ||= at_user.username if at_user
  end

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :content, :created_at
      json.user do |json|
        json.id self.user_id
        json.username self.user_username
      end
      json.at_user do |json|
        if self.at_user_id
          json.id self.at_user_id
          json.username self.at_user_username
        end
      end
    end
  end

end
