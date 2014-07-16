module ShowFor
  module Attribute
    def attribute(attribute_name, options={}, &block)
      apply_default_options!(attribute_name, options)
      block = block_from_value_option(attribute_name, options) unless block
      collection_block, block = block, nil if collection_block?(block)

      value = attribute_value(attribute_name, options, &block)

      wrap_label_and_content(attribute_name, value, options, &collection_block)
    end

    def value(attribute_name, options={}, &block)
      apply_default_options!(attribute_name, options)
      collection_block, block = block, nil if collection_block?(block)

      value = attribute_value(attribute_name, options, &block)

      wrap_content(attribute_name, value, options, &collection_block)
    end

    def attributes(*attribute_names)
      options = attribute_names.extract_options!
      attribute_names.map do |attribute_name|
        attribute(attribute_name, options)
      end.join.html_safe
    end

  private

    def attribute_value(attribute_name, options, &block)
      if block
        block
      else
        args = Array.wrap(options.delete(:args))
        if @object.respond_to?(:"human_#{attribute_name}")
          @object.send :"human_#{attribute_name}", *args
        else
          @object.send attribute_name, *args
        end
      end
    end

    def block_from_value_option(attribute_name, options)
      case options[:value]
      when nil
        nil
      when Symbol
        block_from_symbol(attribute_name, options)
      else
        lambda { options[:value].to_s }
      end
    end

    def block_from_symbol(attribute_name, options)
      attribute = @object.send(attribute_name)
      case attribute
      when Array, Hash
        lambda { |element| element.send(options[:value]) }
      else
        lambda { attribute.send(options[:value]) }
      end
    end
  end
end

