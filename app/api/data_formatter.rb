module DataFormatter
  def self.call(object, env)
    { data: object, success: true }.to_json
  end
end