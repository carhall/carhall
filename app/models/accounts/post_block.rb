class Accounts::PostBlock < ActiveRecord::Base
  include Share::Blockable

end
