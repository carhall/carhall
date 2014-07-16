module IndexFor
  class BuilderProxy
    attr_reader :collection, :klass, :attributes, :actions

    def initialize collection, klass, template
      @collection, @klass, @template = collection, klass, template
      @attributes = []
      @actions = []
    end

    def attribute attribute_name, options={}, &block
      @attributes << {
        type: :attribute,
        name: attribute_name,
        options: options,
        block: block
      }
      nil
    end

    def attributes *attribute_names, &block
      options = attribute_names.extract_options!
      attribute_names.each do |attribute_name|
        @attributes << {
          type: :attribute,
          name: attribute_name,
          options: options,
          block: block
        }
      end
      nil
    end

    def association association_name, options={}, &block
      @attributes << {
        type: :association,
        name: association_name,
        options: options,
        block: block
      }
      nil
    end

    # Used internally to build up cells for common CRUD actions
    def actions *actions
      options = actions.extract_options!
      return if actions.blank?
      actions = [:show, :edit, :destroy] if actions == [:all]
      actions.each do |action|
        action_link(action.to_sym, options)
      end
      nil
    end

    def action_link action, options={}, &block
      link_title = link_title(action)
      html_options = options.delete(:action_html) || {}
      html_options[:class] = "action #{action}_link #{html_options.delete(:class)}"
      html_options.merge!(:method => :delete, 
        :data => { :confirm => confirmation_message }) if action == :destroy

      @actions << {
        name: action,
        link_title: link_title,
        html_options: html_options,
        options: options,
        block: block
      }
      nil
    end

    def to_head options={}
      head_options = apply_wrapper_options!(show_for: :row)
      head_options.merge! options if options
      head_column_options = apply_wrapper_options!(label: :head_column)

      @template.show_for @klass.new, head_options do |s|
        content = @attributes.reduce("") do |ret, p|
          ret += case p[:type]
          when :attribute, :association
            s.label p[:name], head_column_options.merge(p[:options]), false
          end
        end.html_safe 
        content += @template.content_tag(IndexFor.head_column_tag, link_title(:actions), 
          class: IndexFor.actions_column_class) if @actions.any?
        content
      end
    end

    def to_body options={}
      body_options = apply_wrapper_options!(show_for: :row)
      body_options.merge! options if options
      body_column_options = apply_wrapper_options!(content: :content, wrapper: :body_column)

      @collection.reduce("") do |ret, record|
        ret += each_body_row record, body_options, body_column_options
      end.html_safe
    end

  private

    def apply_wrapper_options!(hash)
      hash.reduce({}) do |options, args|
        from, to = args
        options[:"#{from}_tag"] = IndexFor.send(:"#{to}_tag")
        options[:"#{from}_class"] = IndexFor.send(:"#{to}_class")
        options
      end
    end

    def each_body_row record, body_options, body_column_options
      @template.show_for record, body_options do |s|
        content = @attributes.reduce("") do |ret, p|
          ret += case p[:type]
          when :attribute
            s.value p[:name], body_column_options.merge(p[:options]), &p[:block]
          when :association
            s.association_value p[:name], body_column_options.merge(p[:options]), &p[:block]
          end
        end.html_safe
        content += @template.content_tag(IndexFor.body_column_tag, each_body_row_actions(record), 
          class: IndexFor.actions_column_class) if @actions.any?
        content
      end
    end

    def each_body_row_actions record
      @actions.reduce("") do |ret, a|
        ret += if a[:block]
          @template.capture(record, &a[:block]) || ""
        else
          path = if a[:options].has_key? :path
            a[:options][:path].merge(id: record, action: a[:name])
          else
            case a[:name]
            when :show, :destroy
              [a[:options][:prefix], record].compact
            else
              @template.polymorphic_path([a[:options][:prefix], record].compact, 
                :action => a[:name])
            end
          end

          @template.link_to(a[:link_title], path, a[:html_options])
        end
      end.html_safe
    end

    def confirmation_message
      I18n.t("index_for.actions.confirmation", :default => 'Are you sure?')
    end

    def link_title action
      I18n.translate(action, :scope => "index_for.actions", :default => action.to_s.titleize).html_safe
    end

  end
end