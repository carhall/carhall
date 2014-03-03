module GrapeHelper
  def failure! resource
    error! resource.errors.full_messages.first, 422
  end

  def present! resource, options={}
    if resource
      present resource, options.reverse_merge(with: get_entity_class(resource))
    else
      present []
    end
  end

  def get_entity_class resource
    entity = nil
    if resource.kind_of? ActiveRecord::Relation
      resource_class = resource.klass
    else
      resource_class = resource.class
    end
    until entity
      entity = "#{resource_class.name}Entity".constantize rescue nil
      resource_class = resource_class.superclass
    end
    entity
  end
  
  def current_user
    token = params[:auth_token].presence
    Rails.cache.fetch([:current_user, :token, token], expires_in: 1.hour) do
      Accounts::Account.find_by(authentication_token: token) rescue nil
    end
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end
  
end