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

  def invitation_instructions user, opts={}
    @user = user
    sms to: opts[:to]
  end
  
end