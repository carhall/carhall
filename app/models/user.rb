 class User < Account
   set_detail_class Accounts::UserDetail
   
  # For posts
  has_many :posts
  has_many :orders
  has_many :reviews, through: :orders

  def club
    Club.with_user self
  end

end