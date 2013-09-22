class User < Account
  include Share::Statisticable
  
  set_detail_class Accounts::UserDetail
   
  # For posts
  has_many :posts
  has_many :orders
  has_many :recent_orders, conditions: ["orders.created_at > ?", 1.month.ago], class_name: Order
  has_many :last_order, order: 'orders.id DESC', limit: 1, class_name: Order

  has_many :reviews, through: :orders
  has_many :recent_reviews, source: :review, through: :recent_orders
  has_many :last_review, source: :review, through: :last_order
  def club
    Club.with_user self
  end

end