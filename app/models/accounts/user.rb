class Accounts::User < Accounts::Account
  include Share::Statisticable
  
  set_detail_class Accounts::UserDetail
   
  # For posts
  has_many :posts, class_name: 'Posts::Post'
  has_many :orders, class_name: 'Tips::Order'
  has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, class_name: 'Tips::Order'

  has_many :reviews, through: :orders, class_name: 'Tips::Review'
  has_many :recent_reviews, through: :recent_orders, class_name: 'Tips::Review'

  def club
    Posts::Club.with_user self
  end

  def last_3_posts
    posts.includes(:user).first(3)
  end

  api_accessible :detail, extend: :detail do |t|
    t.add :sex_id, append_to: :detail
    t.add :sex, append_to: :detail
    t.add :area_id, append_to: :detail
    t.add :area, append_to: :detail
    t.add :city, append_to: :detail
    t.add :province, append_to: :detail
    t.add :brand_id, append_to: :detail
    t.add :brand, append_to: :detail
    t.add :last_3_posts, append_to: :detail, template: :base
    t.add :posts_count, append_to: :detail
  end

end