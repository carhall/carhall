class Accounts::Wechat <  Accounts::Account

	has_one :buying_advice, class_name: 'Tips::BuyingAdvice', foreign_key: "user_id"
	has_many :orders, class_name: 'Tips::Order', foreign_key: "user_id"
    has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, class_name: 'Tips::Order'
     
    has_many :mending_orders, class_name: 'Tips::MendingOrder', foreign_key: "user_id"
    has_many :free_ticket_orders, class_name: 'Tips::FreeTicketOrder', foreign_key: "user_id"
    has_many :rescue_orders, class_name: 'Tips::RescueOrder', foreign_key: "user_id"
    has_many :cleaning_orders, class_name: 'Tips::CleaningOrder', foreign_key: "user_id"
    has_many :bulk_purchasing_orders, class_name: 'Tips::BulkPurchasingOrder', foreign_key: "user_id"
	
end