class Accounts::User < Accounts::Account
  include Share::Statisticable
  
  set_detail_class Accounts::UserDetail
   
  # For posts
  has_many :posts, class_name: 'Posts::Post'
  has_many :orders, class_name: 'Tips::Order'
  has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, class_name: 'Tips::Order'

  has_many :mending_orders, class_name: 'Tips::MendingOrder'
  has_many :cleaning_orders, class_name: 'Tips::CleaningOrder'
  has_many :bulk_purchasing_orders, class_name: 'Tips::BulkPurchasingOrder'

  has_many :reviews, through: :orders, class_name: 'Tips::Review'
  has_many :recent_reviews, through: :recent_orders, class_name: 'Tips::Review'

  def user?
    true
  end
  
  def club
    Posts::Club.with_user self
  end

  def to_detail_builder
    json = to_base_builder
    json.detail do
      json.merge! (detail||build_detail).to_base_builder.attributes!
      json.extract! self, :sex_id, :sex, :area_id, :area, :city, :province, 
        :brand_id, :brand, :posts_count
      json.last_3_posts(posts.includes(:user).last(3).map{|p|p.to_without_comment_builder.attributes!})
    end
    json
  end

end