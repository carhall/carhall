class Tips::BuyingAdvice < ActiveRecord::Base
  include Share::Userable
  include Tips::Statable

  default_scope { order('id DESC') }

  belongs_to :weixin_user, class_name: 'Accounts::Wechat', foreign_key: "user_id" 
  
  has_many :buying_advice_orders
  alias_attribute :orders, :buying_advice_orders

  #validates_presence_of :user
  validates_presence_of :brand3_id, :buying_at_id, :buying_pattern_id
  validates_inclusion_of :license, in: [true, false], message: "不能为空"

  belongs_to :brand3, class_name: 'Category::Brand3'
  alias_method :rbrand3, :brand3

  enumerate :main_area, with: Category::Area::Main
  enumerate :brand, with: Category::Brand
  enumerate :brand2, with: Category::Brand2
  enumerate :brand3, with: Category::Brand3
  enumerate :buying_at, with: %w(7天内到店 15天内到店 30天内到店)
  enumerate :buying_pattern, with: %w(全款买车 分期付款 置换全款 置换分期)

  before_save do
    self.main_area_id ||= user.main_area_id
    self.brand_id = rbrand3.brand_id
    self.brand2_id = rbrand3.brand2_id
  end

end
