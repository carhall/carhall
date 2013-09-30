class SmsMailer < ActionSms::Base
  def confirmation_instructions user, token, opts={}
    @user = user
    @token = token
    sms to: user.mobile
  end

  def reset_password_instructions user, token, opts={}
    @user = user
    @token = token
    sms to: user.mobile
  end
  
end