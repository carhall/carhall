module ShowFor
  module Association
    def attribute(attribute_name, options={}, &block)
      if association_name = options.delete(:in)
        options[:using] = attribute_name
        options[:i18n_key] ||= :"#{association_name}.#{attribute_name}"
        association(association_name, options, &block)
      else
        super
      end
    end

    def value(attribute_name, options={}, &block)
      if association_name = options.delete(:in)
        options[:using] = attribute_name
        association_value(association_name, options, &block)
      else
        super
      end
    end

    def label(attribute_name, options={}, apply_options=true)
      if association_name = options.delete(:in)
        options[:i18n_key] ||= :"#{association_name}.#{attribute_name}"
      end
      super attribute_name, options, apply_options
    end

    def association(association_name, options={}, &block)
      apply_default_options!(association_name, options)
      collection_block, block = block, nil if collection_block?(block)

      value = value_from_association(association_name, options, &block)

      wrap_label_and_content(association_name, value, options, &collection_block)
    end

    def association_value(association_name, options={}, &block)
      apply_default_options!(association_name, options)
      collection_block, block = block, nil if collection_block?(block)

      value = value_from_association(association_name, options, &block)

      wrap_content(association_name, value, options, &collection_block)
    end

  protected

    def value_from_association(association_name, options, &block)
      # If a block with an iterator was given, no need to calculate the labels
      # since we want the collection to be yielded. Otherwise, calculate the values.
      if block
        block
      else
        association = @object.send(association_name)
        values = values_from_association(association, options)

        if options.delete(:to_sentence)
          values.to_sentence
        elsif joiner = options.delete(:join)
          values.join(joiner)
        else
          values
        end
      end
    end

    def values_from_association(association, options) #:nodoc:
      sample = association.respond_to?(:first) ? association.first : association

      if options[:method]
        options[:using] = options.delete(:method)
        ActiveSupport::Deprecation.warn ":method is deprecated. Please use :using instead", caller
      end

      method = options.delete(:using) || ShowFor.association_methods.find { |m| sample.respond_to?(m) }

      if method
        association.respond_to?(:map) ? association.map(&method) : association.try(method)
      end
    end
  end
end
