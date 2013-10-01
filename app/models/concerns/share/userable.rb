module Share::Userable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :user, class_name: 'Accounts::User'
    scope :with_user, ->(u) { where user_id: Share::Userable.get_id(u) }
  end

  def self.get_id user
    if user.kind_of? Accounts::User then user.id else user end
  end

end
