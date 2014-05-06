class Weixin::ApplicationController < ApplicationController
  skip_before_filter :authenticate_account!
  layout "weixin"

  def self.set_resource_class klass, options = {}
    load_resource :dealer, class: Accounts::Dealer
    super klass, options.reverse_merge(no_authorize: true, through: :dealer)
  end

  def weixin_polymorphic_path *args
    options = args.extract_options!
    paths = []
    paths << options[:action] if options[:action]
    paths << :weixin
    records = []
    args.each do |arg|
      paths << case arg
      when ActiveRecord::Base
        records << arg
        arg.class.model_name.element
      else
        arg.to_s        
      end
    end
    paths << :path
    send paths.join("_"), *records, options
  end

  helper_method :weixin_polymorphic_path
end