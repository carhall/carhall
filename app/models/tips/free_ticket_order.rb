class Tips::FreeTicketOrder <  Tips::Order
  belongs_to :source, class_name: 'FreeTicket', counter_cache: :orders_count

  validates_presence_of :count
  
  def to_base_builder
    json = super
    json.extract! self, :count, :used_count
    json
  end

end
