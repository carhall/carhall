module Accounts
  class AccountEntity < Grape::Entity
    expose :id, :username, :mobile, :description, :user_type
    expose :avatar, format_with: :image
    with_options if: { type: :login } do
      expose :authentication_token
    end
  end
end
