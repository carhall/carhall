class User < Account
  include Share::Statisticable
  
  set_detail_class Accounts::UserDetail
   
  # For posts
  has_many :posts
  has_many :orders
  has_many :recent_orders, conditions: ["orders.created_at > ?", 1.month.ago], class_name: Order

  has_many :reviews, through: :orders
  has_many :recent_reviews, source: :review, through: :recent_orders

  def club
    Club.with_user self
  end

end