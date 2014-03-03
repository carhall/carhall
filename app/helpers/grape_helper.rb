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

end