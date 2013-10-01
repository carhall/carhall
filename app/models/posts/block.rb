class Posts::Block < ActiveRecord::Base
  include Accounts::Blockable

end
