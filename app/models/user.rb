 class User < Account
   set_detail_class Accounts::UserDetail
   
  # For posts
  has_many :posts

  def club
    Club.with_user self
  end

end