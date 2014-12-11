class Cheyouhui::Region < ActiveRecord::Base
	after_create :generate_qrcode
	def generate_qrcode
       weixin = $cheyouhui.create_qr_limit_scene(id)
       result = weixin.result
       self.url = result["url"]
       self.token = result["ticket"]
       self.save
	end
end
