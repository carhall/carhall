module Share
  module Detailable
    extend ActiveSupport::Concern

    included do
      belongs_to :detail, polymorphic: true, autosave: true, dependent: :destroy
      # accepts_nested_attributes_for :detail, :allow_destroy => true
      # attr_accessible :detail_attributes
    end

    def detail_type_sym
      @detail_typehood ||= (detail_type.demodulize.gsub('Info', '').underscore.to_sym rescue :admin)
    end

    def build_detail params = {}
      self.detail = detail_class.new(params)
    end

    def detail= params
      if params.kind_of? Hash
        if detail
          self.detail.attributes = params
        else
          super detail_class.new(params.merge(source: self))
        end
      else
        super params
      end
    end

    module ClassMethods
      def set_detail_class klass, options = {}
        define_method :detail_class do
          klass
        end

        default_scope { where(detail_type: klass) }

        after_initialize do |params|
          build_detail unless detail
        end
      end
    end
    
  end
end