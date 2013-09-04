class Comment < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :source, polymorphic: true, counter_cache: true

  attr_accessible :content
  attr_accessible :user, :source

  def serializable_hash(options={})
    options = { 
      only: [:id, :content],
      include: [:user]
    }.update(options)
    super(options)
  end

end
