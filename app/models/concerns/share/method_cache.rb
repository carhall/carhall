module Share::MethodCache
  def define_cached_methods *methods
    options = methods.extract_options!
    methods.each do |method|
      method = method.to_sym
      method_without_cache = :"#{method}_without_cache"
      class_eval do
        alias_method method_without_cache, method
        define_method method do |*args|
          Rails.cache.fetch([self.class, self.id, method, *args, options[:version]], 
            expires_in: options[:expires_in]) do
            send method_without_cache, *args
          end
        end
      end
    end
  end
end
