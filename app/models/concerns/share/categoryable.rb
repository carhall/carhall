module Share::Categoryable
  extend ActiveSupport::Concern

  included do
    acts_as_enum

    after_commit :flush_cache

    validates_presence_of :name 
    validates_uniqueness_of :name
  end
  
  def flush_cache
    Rails.cache.delete([self.class, self.id])
  end

  module ClassMethods
    def lookup_by_id(index)
      Rails.cache.fetch([self, index], expires_in: 1.day) do
        enum_values.find_by_id(index)
      end
    end
  end

end