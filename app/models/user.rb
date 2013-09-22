class User < Account
  include Share::Statisticable
  
  set_detail_class Accounts::UserDetail
   
  # For posts
  has_many :posts
  has_many :orders
  has_many :recent_orders, conditions: ["orders.created_at > ?", 1.month.ago], class_name: Order

  has_many :reviews, through: :orders
  has_many :recent_reviews, through: :recent_orders, class_name: Review
  
  def club
    Club.with_user self
  end

  def detail_hash
    detail_hash = detail.serializable_hash
    detail_hash[:posts_count] = posts.count
    detail_hash[:last_3_posts] = posts.includes(:user).last(3)
    serializable_hash.merge(detail: detail_hash)
  end

end