module ActiveEnum
  class EnumNotFound < StandardError; end

  module Extensions
    extend ActiveSupport::Concern

    included do
      class_attribute :enumerated_attributes
    end

    module ClassMethods

      # Declare an attribute to be enumerated by an enum class
      #
      # Example:
      #   class Person < ActiveRecord::Base
      #     enumerate :sex, :with => Sex
      #     enumerate :sex # implies a Sex enum class exists
      #
      #     # Pass a block to create implicit enum class namespaced by model e.g. Person::Sex
      #     enumerate :sex do
      #       value :id => 1, :name => 'Male'
      #     end
      #
      #     # Multiple attributes with same enum
      #     enumerate :to, :from, :with => Sex
      #
      def enumerate(*attributes, &block)
        options = attributes.extract_options!
        self.enumerated_attributes ||= {}

        attributes_enum = {}
        attributes.each do |attribute|
          begin
            if block_given?
              enum = define_implicit_enum_class_for_attribute(attribute, block)
            else
              klass = options[:with] || attribute.to_s.camelize.constantize
              if klass.is_a? Array
                block = Proc.new { value klass }
                enum = define_implicit_enum_class_for_attribute attribute, block
              else
                enum = klass
              end
            end

            attribute = attribute.to_sym
            attributes_enum[attribute] = enum

            if options[:multiple]
              column = options[:column] || "#{attribute.to_s.singularize}_ids"
            else
              column = options[:column] || "#{attribute}_id"
            end
            column = column.to_sym
            raise ArgumentError('Do not use the same name for the enum as for the column') if column == attribute

            if options[:multiple]
              define_active_enum_methods_for_attribute_multiple(attribute, column, options)
            else
              define_active_enum_methods_for_attribute(attribute, column, options)
            end
          rescue NameError => e
            raise e unless e.message =~ /uninitialized constant/
            raise ActiveEnum::EnumNotFound, "Enum class could not be found for attribute '#{attribute}' in class #{self}. Specify the enum class using the :with option."
          end
        end
        enumerated_attributes.merge!(attributes_enum)
      end

      def active_enum_for(attribute)
        enumerated_attributes && enumerated_attributes[attribute.to_sym]
      end

      def define_active_enum_methods_for_attribute(attribute, column, options)
        define_active_enum_get_id_for_attribute_method(attribute)
        define_active_enum_read_method(attribute, column)
        define_active_enum_write_method(attribute, column)
        define_active_enum_question_method(attribute, column)

        # support dirty attributes by delegating to column, currently opt-in
        # if options[:dirty]
          define_active_enum_dirty_methods_for_attribute(attribute, column)
        # end

        # support scope by delegating to where(column: enum_id), currently opt-in
        # if options[:scope]
          define_active_enum_scope_for_attribute(attribute, column)
        # end
      end

      def define_active_enum_methods_for_attribute_multiple(attribute, column, options)
        define_active_enum_get_id_for_attribute_method(attribute)
        define_active_enum_read_method_multiple(attribute, column)
        define_active_enum_write_method_multiple(attribute, column)
        define_active_enum_question_method_multiple(attribute, column)

        # support dirty attributes by delegating to column, currently opt-in
        if options[:dirty]
          define_active_enum_dirty_methods_for_attribute(attribute, column)
        end
      end

      def define_implicit_enum_class_for_attribute(attribute, block)
        enum_class_name = "#{name}::#{attribute.to_s.singularize.camelize}"
        eval("class #{enum_class_name} < ActiveEnum::Base; end")
        enum = enum_class_name.constantize
        enum.class_eval &block
        enum
      end

      def define_active_enum_get_id_for_attribute_method(attribute)
        class_eval <<-DEF
          def self.active_enum_get_id_for_#{attribute}(arg)
            if arg.is_a?(Integer)
              arg
            else
              active_enum_for(:#{attribute})[arg]
            end
          end
        DEF
      end

      # Define scope for the enum component
      #
      # Examples:
      #   User.by_sex(1)
      #   User.by_sex(:male)
      #
      def define_active_enum_scope_for_attribute(attribute, column)
        class_eval <<-DEF
          scope :"with_#{attribute.to_s.singularize}", ->(arg) { where(#{column}: active_enum_get_id_for_#{attribute}(arg)) }
        DEF
      end

      # Define dirty attribute methods by delegating to column
      #
      # Examples:
      #   user.sex_changed?
      #   user.sex_was
      #
      def define_active_enum_dirty_methods_for_attribute(attribute, column)
        class_eval <<-DEF
          def #{attribute}_changed?
            #{column}_changed?
          end
          
          def #{attribute}_was arg
            value = self.#{column}_was
            return if value.nil? && arg.nil?
            active_enum_translate_#{attribute}(arg, value)
          end
        DEF
      end

      # Define read method to allow an argument for the enum component
      #
      # Examples:
      #   user.sex
      #   user.sex(:id)
      #   user.sex(:name)
      #   user.sex(:enum)
      #   user.sex(:meta_key)
      #
      def define_active_enum_read_method(attribute, column)
        class_eval <<-DEF
          def active_enum_translate_#{attribute}(arg, value)
            enum = self.class.active_enum_for(:#{attribute})
            arg ||= #{ActiveEnum.use_name_as_value ? ':name' : ':id' }
            case arg
            when :id
              if enum[value] then value else 0 end
            when :name
              enum[value] || I18n.t('unknown', scope: :active_enum, default: 'Unknown')
            when :enum
              enum
            when Symbol
              (enum.meta(value) || {})[arg]
            end
          end
          
          def #{attribute}(arg=nil)
            value = self.#{column}
            active_enum_translate_#{attribute}(arg, value)
          end

          def human_#{attribute}
            enum = self.class.active_enum_for(:#{attribute})
            value = self.#{column}
            enum[value]
          end
        DEF
      end

      # Define write method to also handle enum value
      #
      # Examples:
      #   user.sex = 1
      #   user.sex = :male
      #
      def define_active_enum_write_method(attribute, column)
        class_eval <<-DEF
          def #{attribute}=(arg)
            self.#{column} = self.class.active_enum_get_id_for_#{attribute}(arg)
          end
        DEF
      end

      # Define question method to check enum value against attribute value
      #
      # Example:
      #   user.sex?(:male)
      #
      def define_active_enum_question_method(attribute, column)
        class_eval <<-DEF
          def #{attribute}?(arg=nil)
            if arg
              self.#{attribute}(:id) == self.class.active_enum_get_id_for_#{attribute}(arg)
            else
              self.#{column}?
            end
          end
        DEF
      end

      # Define read method to allow an argument for the enum component
      #
      # Examples:
      #   user.sex
      #   user.sex(:id)
      #   user.sex(:name)
      #   user.sex(:enum)
      #   user.sex(:meta_key)
      #
      def define_active_enum_read_method_multiple(attribute, column)
        class_eval <<-DEF
          def active_enum_translate_#{attribute}(arg, value)
            enum = self.class.active_enum_for(:#{attribute})
            arg ||= #{ActiveEnum.use_name_as_value ? ':name' : ':id' }
            value ||= []
            case arg
            when :id
              value.select { |i| enum[i] }
            when :name
              value.map { |i| enum[i] }.select { |n| n }
            when :enum
              enum
            when Symbol
              value.map { |i| (enum.meta(i) || {})[arg] }
            end
          end
          
          def #{attribute}(arg=nil)
            value = self.#{column}
            return [] if (value.nil? || value.empty?) && arg.nil?
            active_enum_translate_#{attribute}(arg, value).compact
          end

          def #{column}= ids
            super ids.select{|i|i.present?}.map(&:to_i)
          end

        DEF
      end

      # Define write method to also handle enum value
      #
      # Examples:
      #   user.sex = 1
      #   user.sex = :male
      #
      def define_active_enum_write_method_multiple(attribute, column)
        class_eval <<-DEF
          def #{attribute}=(args)
            self.#{column} = args.map do |arg|
              self.class.active_enum_get_id_for_#{attribute}(arg)
            end
          end
        DEF
      end

      # Define question method to check enum value against attribute value
      #
      # Example:
      #   user.sex?(:male)
      #
      def define_active_enum_question_method_multiple(attribute, column)
        class_eval <<-DEF
          def #{attribute}?(arg=nil)
            if arg
              self.#{attribute}(:id).include? self.class.active_enum_get_id_for_#{attribute}(arg)
            else
              self.#{column}?
            end
          end
        DEF
      end

    end

  end
end
