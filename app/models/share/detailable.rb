module Share
  module Detailable
    extend ActiveSupport::Concern

    included do
      belongs_to :detail, polymorphic: true, autosave: true, dependent: :destroy
      accepts_nested_attributes_for :detail, allow_destroy: true, update_only: true
      attr_accessible :detail_attributes
    end

    def detail_type_sym
      @detail_typehood ||= if new_record?
        :guest
      elsif detail.nil?
        :admin
      else
        detail_type.demodulize.gsub('Info', '').underscore.to_sym
      end
    end

    def detail= params
      if params.kind_of? Hash
        self.detail_attributes = params
      else
        super params
      end
    end

    module ClassMethods
      def set_detail_class klass, options = {}
        define_method :build_detail do |params={}, assignment_options={}|
          self.detail = klass.new params
        end

        default_scope { where(detail_type: klass) }

        after_initialize do
          build_detail unless detail
        end

      end
    end
    
  end
end