class Accounts::Block < ActiveRecord::Base
  self.table_name = "blacklist"
  
  include Accounts::Blockable

end
