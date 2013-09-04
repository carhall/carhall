module Auth
  class Friendship < ActiveRecord::Base
    belongs_to :user, class_name: "BaseUser"
    belongs_to :friend, class_name: "BaseUser"

    attr_accessible :friend_id, :user_id

    validates_each :friend_id do |record, attr, value|
      if record.user.blocks.where(blacklist_id: value).any?
        record.errors.add(attr, I18n.t('in_blacklist')) 
      end
    end
  end
end
