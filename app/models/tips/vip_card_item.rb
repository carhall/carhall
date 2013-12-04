class Tips::VipCardItem < ActiveRecord::Base
  belongs_to :vip_card, class_name: 'Tips::VipCard'
  
  validates_presence_of :title, :count

  def destroy
    self.vip_card = nil
    self.save(validate: false)
  end
  
  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :count
    end
  end

end