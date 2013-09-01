module Share
  module Id2Key
    def self.clean_up_ids ids
      ret = []
      ids.each do |i|
        ret << i.to_i if i.present?
      end
      ret
    end

    def define_id2key_methods attr_name
      attr_name = attr_name.to_s
      attr_id_name = attr_name+'_id'
      array_name = attr_name.camelcase.pluralize
      class_eval <<-EOM
        def #{attr_name}
          return I18n.t('.unknown') unless #{attr_id_name}
          #{array_name}[#{attr_id_name}]
        end

        def #{attr_name}= #{attr_name}
          self.#{attr_id_name} = #{array_name}.index #{attr_name}
        end
      EOM
    end

    def define_ids2keys_methods attrs_name
      attrs_name = attrs_name.to_s
      attr_ids_name = attrs_name.singularize+'_ids'
      array_name = attrs_name.camelcase
      class_eval <<-EOM
        serialize :#{attr_ids_name}

        def #{attrs_name}
          @#{attrs_name} ||= (#{attr_ids_name}||[]).map do |id|
            #{array_name}[id]
          end
        end

        def #{attrs_name}= #{attrs_name}
          @#{attrs_name} = #{attrs_name}
        end

        def #{attr_ids_name}= #{attr_ids_name}
          super Share::Id2Key.clean_up_ids #{attr_ids_name}
        end

        before_save do
          self.#{attr_ids_name} = @#{attrs_name}.map do |key|
            #{array_name}.index key
          end if @#{attrs_name}
        end
      EOM
    end
  end
end