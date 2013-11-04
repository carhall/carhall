module Share::Userable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :user, class_name: 'Accounts::User'
    scope :with_user, ->(u) { where user_id: u }
  end

end
