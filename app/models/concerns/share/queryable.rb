module Share::Queryable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :indexes
  end

  module ClassMethods
    def with_query query
      sql_where_query = indexes.map{|i| "#{i} LIKE '%#{query}%'" }.join(' or ')
      where sql_where_query
    end

    def define_queryable_column *args
      self.indexes = args
    end
  end

end