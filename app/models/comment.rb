class Comment < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :post, counter_cache: true
  belongs_to :at_user

  attr_accessible :content
  attr_accessible :user, :post, :at_user
  attr_accessible :at_user_id

  validates_presence_of :user
  validates_presence_of :content
  
  def serializable_hash(options={})
    options = { 
      only: [:id, :content],
      include: [:user, :at_user]
    }.update(options)
    super(options)
  end

end
