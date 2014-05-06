class Accounts::User < Accounts::Account
  include Share::Statisticable
  
  set_detail_class Accounts::UserDetail
  define_avatar_method styles: { medium: "200x200#", thumb: "60x60#" }
  
  validates_presence_of :brand_id, :area_id

  # For posts
  has_many :posts, class_name: 'Posts::Post', dependent: :destroy
  has_many :comments, class_name: 'Posts::Comment', dependent: :destroy
  has_many :orders, class_name: 'Tips::Order'
  has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, class_name: 'Tips::Order'

  has_many :mending_orders, class_name: 'Tips::MendingOrder'
  has_many :cleaning_orders, class_name: 'Tips::CleaningOrder'
  has_many :bulk_purchasing_orders, class_name: 'Tips::BulkPurchasingOrder'
  has_many :vip_card_orders, class_name: 'Tips::VipCardOrder'

  has_many :reviews, through: :orders, class_name: 'Tips::Review'
  has_many :recent_reviews, through: :recent_orders, source: :review, class_name: 'Tips::Review'

  has_many :consumption_records, class_name: 'Statistic::ConsumptionRecord'
  has_many :sales_cases, class_name: 'Statistic::SalesCase'


  def self.with_query query
    sql_where_query = indexes.map{|i| "`accounts`.`#{i}` LIKE '#{query}%'" }.join(' or ')
    sql_where_query += " or `user_details`.`plate_num` LIKE '#{query}'"
    joins(:detail).where(sql_where_query)
  end

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