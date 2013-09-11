module Auth
  class Friendship < ActiveRecord::Base
    belongs_to :user, class_name: "User"
    belongs_to :friend, class_name: "User"

    attr_accessible :friend_id, :user_id

    validates_each :friend_id do |record, attr, value|
      if record.user.blocks.where(blacklist_id: value).any?
        record.errors.add(:base, I18n.t('in_blacklist')) 
      end

      if value == record.user_id
        record.errors.add(:base, I18n.t('can_not_add_self')) 
      end
    end
  end
end
