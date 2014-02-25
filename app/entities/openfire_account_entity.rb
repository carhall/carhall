class OpenfireAccountEntity < Grape::Entity
  def avatar_thumb_url avatar
    "#{AbsoluteUrlPrefix}#{avatar.url(:thumb, timestamp: false)}" if avatar.present?
  end
  
  def user_type_id user
    { guest: 1, admin: 2, user: 3, dealer: 4, provider: 5, 
      distributor: 6, agent: 7 }[user.user_type]
  end

  expose :id, :mobile
  expose :username, if: { type: :detail }
  expose :user_type_id do |user, options|
    user_type_id user
  end
  expose :authentication_token, as: :token, if: { type: :login }
  expose :sex_id, if: { type: :detail } do |user, options|
    user.sex_id || 0
  end
  expose :avatar_thumb_url, if: { type: :detail } do |user, options|
    avatar_thumb_url user.avatar
  end
end
