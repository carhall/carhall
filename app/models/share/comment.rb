class Share::Comment < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :source, polymorphic: true
  belongs_to :at_user, class_name: 'Accounts::User'

  validates_presence_of :user, :source
  validates_presence_of :content
  
  acts_as_api

  api_accessible :base, includes: [:user, :at_user] do |t|
    t.only :id, :content, :created_at
    t.add :user, template: :base
    t.add :at_user, template: :base
  end

end
