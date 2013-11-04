module Share::Detailable
  extend ActiveSupport::Concern

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

      after_initialize do
        detail ||= build_detail
      end

    end
  end
  
end
