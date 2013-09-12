module Share
  module Detailable
    extend ActiveSupport::Concern

    def type_sym
      return :guest if new_record?
      return :user unless type
      type.underscore.to_sym
    end

    module ClassMethods 
      def set_detail_class klass
        belongs_to :detail, class_name: klass, autosave: true, dependent: :destroy
        accepts_nested_attributes_for :detail, allow_destroy: true, update_only: true

        define_method :detail= do |args|
          if args.kind_of? klass
            super args
          else
            self.detail_attributes = args
          end
        end

      end
    end
  end
end