class Tips::TestDriveOrder < Tips::Order
  belongs_to :source, class_name: 'TestDrive', counter_cache: :orders_count

  validates_presence_of :count

end
