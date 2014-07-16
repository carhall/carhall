module IndexFor
  module Helper
    # Creates a div around the object and yields a builder.
    #
    # Example:
    #
    #   index_for @user do |f|
    #     f.attribute :name
    #     f.attribute :email
    #   end
    #
    def index_for(collection, html_options={}, &block)
      html_options = html_options.dup

      tag = html_options.delete(:index_for_tag) || IndexFor.index_for_tag
      klass = index_for_class(collection)

      html_options[:id]  ||= index_for_id(klass)
      html_options[:class] = index_for_html_class(collection, html_options)

      builder = html_options.delete(:builder) || IndexFor::BuilderProxy
      b = builder.new(collection, klass, self)
      yield b

      head_tag = html_options.delete(:head_tag) || IndexFor.head_tag
      if head_tag
        head_options = html_options.delete(:head_options)
        head_html_options = html_options.delete(:head_html) || {}
        head_html_options[:class] = IndexFor.head_class
        head = content_tag head_tag, b.to_head(head_options), head_html_options
      else
        head = ""
      end

      body_tag = html_options.delete(:body_tag) || IndexFor.body_tag
      body_options = html_options.delete(:body_options)
      body_html_options = html_options.delete(:body_html) || {}
      body_html_options[:class] = IndexFor.body_class
      body = content_tag body_tag, b.to_body(body_options), body_html_options

      content_tag(tag, head + body, html_options)
    end

    private

    # Finds the class representing the objects within the collection
    def index_for_class(collection)
      if collection.respond_to?(:klass) # ActiveRecord::Relation
        collection.klass
      elsif !collection.empty?
        collection.first.class
      end
    end

    def index_for_id(klass)
      klass ? klass.model_name.plural : ""
    end

    def index_for_html_class(collection, html_options)
      "index_for #{html_options[:id]} #{html_options[:class]} #{IndexFor.index_for_class}".squeeze(" ").rstrip
    end
  end
end

ActionView::Base.send :include, IndexFor::Helper
