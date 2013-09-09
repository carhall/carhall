module Share
  module Ids2Users
    def define_ids2users_methods attrs_name
      attrs_name = attrs_name.to_s
      attr_ids_name = attrs_name.singularize+'_ids'
      class_eval <<-EOM
        serialize :#{attr_ids_name}, Array

        def #{attrs_name}
          @#{attrs_name} ||= User.where(id: #{attr_ids_name})
        end

        def #{attrs_name}= users
          @#{attrs_name} = users
          #{attr_ids_name} = users.pluck(:id)
        end
      EOM
    end
  end
end