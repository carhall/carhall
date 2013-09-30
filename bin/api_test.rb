require 'net/http'
 
url = URI.parse('http://localhost:3000/base_users/login.json')
Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Post.new(url.path)
  req.set_form_data({ 'base_user[email]' => 'bbtfr@vip.qq.com', 'base_user[password]' => 'fdsafdsa' })
  puts http.request(req).body

  url = URI.parse('http://localhost:3000/base_users.json?auth_token=tGzyxy9iNS4Aze9tGs7y')
  req = Net::HTTP::Get.new(url.path)
  puts http.request(req).body
end
