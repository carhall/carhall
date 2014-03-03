class OpenfireAccountEntity < Grape::Entity
  root :users, :user
  
  expose :id, :mobile
  expose :user_type_id do |user, options|
    { guest: 1, admin: 2, user: 3, dealer: 4, provider: 5, 
      distributor: 6, agent: 7 }[user.user_type]
  end
  with_options if: { type: :detail } do
    expose :username 
    expose :sex_id do |user, options|
      user.sex_id || 0
    end
    expose :avatar_thumb_url do |user, options|
      absolute_image_url(user.avatar, :thumb) if user.avatar.present?
    end
  end
  expose :authentication_token, as: :token, if: { type: :login }
end
