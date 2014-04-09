module Share::UserInfoable
  extend ActiveSupport::Concern

  def user_info  
    self.try(:user) || OpenStruct.new(
      id: nil,
      username: self.try(:user_username),
      mobile: self.try(:user_mobile),
      brand: self.try(:user_brand),
      plate_num: self.try(:user_plate_num)
    )
  end

end
