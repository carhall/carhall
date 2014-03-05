module Statistic
  class UserInfoEntity < Grape::Entity
    expose :id, :username, :mobile, :brand, :plate_num
  end
end