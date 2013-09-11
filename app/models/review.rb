class Review < ActiveRecord::Base
  belongs_to :order, class_name: 'BaseOrder'

  attr_accessible :content, :stars
  attr_accessible :order

  validates_presence_of :content, :stars
  validates_numericality_of :stars, greater_than_or_equal_to: 0, less_than_or_equal_to: 5, allow_nil: true

  def serializable_hash(options={})
    options = { 
      only: [:id, :content, :stars],
    }.update(options)
    super(options)
  end

end
