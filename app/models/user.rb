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

  api_accessible :detail, extend: :detail do |t|
    t.add ->(u) { u.posts.includes(:user).last(3) }, as: :last_3_posts, append_to: :detail
    t.add :posts_count, append_to: :detail, template: :base
  end

end