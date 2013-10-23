module Accounts::Blockable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :blacklist, class_name: 'Accounts::Account'

    # attr_accessible :blacklist_id, :user_id
  end

end
