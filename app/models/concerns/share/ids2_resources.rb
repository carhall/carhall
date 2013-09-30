module Share::Ids2Resources
  def define_ids2resources_methods klass, attrs_name
    attrs_name = attrs_name.to_s
    attr_ids_name = attrs_name.singularize+'_ids'
    class_eval <<-EOM
      serialize :#{attr_ids_name}, Array

      def #{attrs_name}
        @#{attrs_name} ||= #{klass}.find(#{attr_ids_name})
      end

      def #{attrs_name}= resources
        @#{attrs_name} = resources
        #{attr_ids_name} = resources.pluck(:id)
      end
    EOM
  end
end
