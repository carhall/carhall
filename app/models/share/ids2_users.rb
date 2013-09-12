module Share
  module Ids2Users
    include Ids2Resources

    def define_ids2users_methods attrs_name
      define_ids2resources_methods User, attrs_name
    end
  end
end