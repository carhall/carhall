class Bcst::TrafficReport < Share::Comment
  default_scope { order('id DESC') }
  
  def self.with_provider provider
    provider = if provider.kind_of? Accounts::Provider then 
      provider else Accounts::Provider.find(provider) end
    provider.traffic_reports
  end

end