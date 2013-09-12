class Posts::MechanicCandidate < Share::OpenDatabaseStruct
  alias_attribute :description, :content
  attr_accessible :user_id, :description

end