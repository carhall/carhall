class Category::ApplicationController < ApplicationController

  def self.set_resource_class klass, options={}
    super klass, options.reverse_merge(title: :name)
  end

end