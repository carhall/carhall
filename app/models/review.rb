class Review < ActiveRecord::Base
  include Share::Userable
  
  has_one :order, class_name: 'BaseOrder'
  # has_one :user, through: :order

  attr_accessible :content, :stars, :user, :order

  def serializable_hash(options={})
    options = { 
      only: [:id, :content, :stars],
      include: [:order]
    }.update(options)
    super(options)
  end

end
