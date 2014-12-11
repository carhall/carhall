module CheyouhuiHelper

    def response_for_click(tag)
    	# binding.pry
    	host = "http://115.28.13.212"
    	 token = @weixin_message["FromUserName"]
    	
    	 Rails.logger.info(token)
    	case tag
    	when "free_ticket"
    	    article=[generate_article("免费优惠券","免费优惠券,应有尽有","weixin/secondhand_appraise.png","#{host}/weixin/cheyouhui/free_tickets?token=#{token}")]  		
    	when "tuangou"
    		article=[generate_article("团购","车友会的团购,自己的团购","weixin/secondhand_appraise.png","#{host}/weixin/cheyouhui/groupons?token=#{token}")]    		
    	when "xiche"
    		article=[generate_article("洗车","洗车","weixin/secondhand_appraise.png","#{host}/weixin/cheyouhui/cleanings?type=cleaning&token=#{token}")]  		
    	when "buycar"
    		article=[generate_article("会买车","一键获得最低价，买车用我更实惠","weixin/buying_advice.png","#{host}/weixin/cheyouhui/buycars?token=#{token}")]
    	when "yuding"
    		article=[generate_article("预定信息","点击进入，查看等多预定信息","weixin/buying_advice.png","#{host}/weixin/cheyouhui/my?token=#{token}")]
    	when 'baoyang'
    		article=[generate_article("保养","查看等多保养信息","weixin/buying_advice.png","#{host}/weixin/cheyouhui/cleanings?type=mending&token=#{token}")]
    	end
    	reply_news_message(article)
    		
    	 #reply_text_message("你点击了: #{tag}")
    end
end