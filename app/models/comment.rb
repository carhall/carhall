class Comment < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :post, counter_cache: true

  attr_accessible :content
  attr_accessible :user, :post

  validates_presence_of :user
  validates_presence_of :content
  
  def serializable_hash(options={})
    options = { 
      only: [:id, :content],
      include: [:user]
    }.update(options)
    super(options)
  end

end
