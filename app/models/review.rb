class Review < ActiveRecord::Base
  belongs_to :order

  attr_accessible :content, :stars
  attr_accessible :order

  validates_presence_of :order
  validates_presence_of :content, :stars
  validates_numericality_of :stars, greater_than_or_equal_to: 0, less_than_or_equal_to: 5, allow_nil: true

  def serializable_hash(options={})
    options = { 
      only: [:id, :content, :stars],
    }.update(options)
    super(options)
  end

  def self.stars
    average(:stars)
  end

  def self.trend_stars
    where("reviews.created_at > ?", 1.month.ago).average(:stars)
  end

  def self.last_stars
    last.stars if any?
  end

end
