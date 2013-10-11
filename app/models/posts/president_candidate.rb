class Posts::PresidentCandidate < Share::OpenDatabaseStruct
  alias_attribute :description, :content

  validates_presence_of :user
  validates_presence_of :content
  
end