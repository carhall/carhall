class SmsMailer < ActionSms::Base
  def confirmation_instructions user, opts
    @user = user
    sms to: user.mobile
  end
end