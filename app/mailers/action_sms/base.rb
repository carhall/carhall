require_relative 'log_subscriber'

module ActionSms
  class Base < AbstractController::Base
    abstract!
    private_class_method :new #:nodoc:

    include AbstractController::Logger
    include AbstractController::Rendering
    include AbstractController::Layouts
    include AbstractController::Helpers
    include AbstractController::Translation
    include AbstractController::AssetPaths
    include AbstractController::Callbacks

    class << self
      def respond_to?(method, include_private = false) #:nodoc:
        super || action_methods.include?(method.to_s)
      end

      def method_missing(method_name, *args)
        if respond_to?(method_name)
          new(method_name, *args).message
        else
          super
        end
      end
    end
    
    attr_internal :message

    self.view_paths = ActionController::Base.view_paths

    def initialize method_name, *args
      @_sms_was_called = false
      @_message = SMS.new
      process(method_name, *args) if method_name
    end

    def process(*args) #:nodoc:
      lookup_context.skip_default_locale!

      super
      @_message = NullSMS.new unless @_sms_was_called
    end

    def sms(headers = {})
      @_sms_was_called = true
      m = @_message
      m.to = headers[:to]

      if headers[:body]
        m.body = headers.delete(:body)
      else
        templates_path = headers.delete(:template_path) || self.class.controller_path
        templates_name = headers.delete(:template_name) || action_name
        template = lookup_context.find(templates_name, Array.wrap(templates_path))
        m.body = render(template: template)
      end

      m
    end
  end
end