require 'erb'

namespace :api do

  task :doc => :environment do
    erb = ERB.new(File.open(File.join(Rails.root, 'lib/tasks/templates/api.md.erb')).read, nil, '%<>-')
    api = AssistantAPI
    api_prefix = '/assistant'
    File.open(File.join(Rails.root, 'doc/assistant.md'), "w").puts erb.result binding
  end
end
