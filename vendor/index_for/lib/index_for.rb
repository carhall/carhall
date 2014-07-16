require 'action_view'
require 'index_for/helper'

module IndexFor
  autoload :BuilderProxy, 'index_for/builder_proxy'

  mattr_accessor :index_for_tag
  @@index_for_tag = :table

  mattr_accessor :index_for_class
  @@index_for_class = nil
  
  mattr_accessor :head_tag
  @@head_tag = :thead

  mattr_accessor :head_class
  @@head_class = nil

  mattr_accessor :body_tag
  @@body_tag = :tbody

  mattr_accessor :body_class
  @@body_class = nil

  mattr_accessor :head_column_tag
  @@head_column_tag = :th

  mattr_accessor :head_column_class
  @@head_column_class = nil
  
  mattr_accessor :body_column_tag
  @@body_column_tag = :td

  mattr_accessor :body_column_class
  @@body_column_class = nil

  mattr_accessor :row_tag
  @@row_tag = :tr

  mattr_accessor :row_class
  @@row_class = nil

  mattr_accessor :content_tag
  @@content_tag = :span

  mattr_accessor :content_class
  @@content_class = nil

  mattr_accessor :actions_column_class
  @@actions_column_class = :actions



  # Yield self for configuration block:
  #
  #   IndexFor.setup do |config|
  #     config.index_for_tag = :div
  #   end
  #
  def self.setup
    yield self
  end
end
