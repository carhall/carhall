module CanCan
  ControllerResource.class_eval do
    def id_param
      if @options[:id_param]
        String(@params[@options[:id_param]])
      else
        @params[parent? ? "#{name}_id" : 'id']
      end
    end
  end
end