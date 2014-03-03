module Share::Detailable
  extend ActiveSupport::Concern

  # Fake detail
  attr_accessor :detail
  def detail
    @detail ||= self.build_detail rescue OpenStruct.new
  end
  def detail_attributes= hash=nil; end

  module ClassMethods
    def set_detail_class klass, options={}
      cattr_accessor :detail_class
      self.detail_class = klass

      belongs_to :detail, class_name: klass, autosave: true, dependent: :destroy
      accepts_nested_attributes_for :detail, allow_destroy: true, update_only: true

      define_method :detail= do |args|
        if args.kind_of? klass
          super args
        else
          self.detail_attributes = args
        end
      end

      detail_delegates = (klass.attribute_names - attribute_names)
        .map{ |d| [d, :"#{d}="] }.flatten
      delegate *detail_delegates, to: :detail, allow_nil: true
    end
  end

end
