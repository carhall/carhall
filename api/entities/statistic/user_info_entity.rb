module Statistic
  class UserInfoEntity < Grape::Entity
    expose :username, :mobile, :brand, :plate_num
  end
end