module Share::Userable
  extend ActiveSupport::Concern
    
  included do
    belongs_to :user
    scope :with_user, ->(u) { where user_id: Share::Userable.get_id(u) }
  end

  def self.get_id user
    if user.kind_of? User then user.id else user end
  end

end
