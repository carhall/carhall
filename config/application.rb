require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Carhall
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local  
    config.time_zone = 'Beijing'  

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :'zh-CN'

    config.action_dispatch.rescue_responses["CanCan::AccessDenied"] = :forbidden
    config.action_dispatch.rescue_responses["ActiveRecord::AssociationTypeMismatch"] = :unprocessable_entity

    # For grape api
    config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')
    config.paths.add File.join('app', 'entities'), glob: File.join('**', '*.rb')
    config.paths.add File.join('app', 'formatters'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]
    config.autoload_paths += Dir[Rails.root.join('app', 'entities', '*')]
    config.autoload_paths += Dir[Rails.root.join('app', 'formatters', '*')]
  end
end
