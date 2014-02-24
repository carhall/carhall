module Formatters::ErrorFormatter
  def self.call(message, backtrace, options, env)
    { error: message, success: false }.to_json
  end
end