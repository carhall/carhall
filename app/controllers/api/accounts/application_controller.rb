class Api::Accounts::ApplicationController < Api::ApplicationController

  def self.set_resource_class klass, options = {}
    super klass, options

    if options[:display]
      define_method :set_parent do
        @parent = klass.ordered
      end
    end
  
  end

end