class Tips::TestDrivingOrder < Tips::Order
  belongs_to :source, class_name: 'TestDriving', counter_cache: :orders_count

  validates_presence_of :count

end
