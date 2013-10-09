class Accounts::Friendship < ActiveRecord::Base
  self.table_name = "friend"

  belongs_to :user
  belongs_to :friend, class_name: 'Account'

  validates_presence_of :user, :friend

  validates_each :friend_id do |record, attr, value|
    next unless value
    if record.user.blocks.where(blacklist_id: value).any?
      record.errors.add(:base, I18n.t('in_blacklist')) 
    end

    if value == record.user_id
      record.errors.add(:base, I18n.t('can_not_add_self')) 
    end
  end
end
