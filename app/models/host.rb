class Host < ActiveRecord::Base
  belongs_to :provider

  extend Share::Ids2Resources
  define_ids2resources_methods Programme, :programmes

end
