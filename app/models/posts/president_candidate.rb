class Posts::PresidentCandidate < Share::OpenDatabaseStruct
  alias_attribute :description, :content
  # attr_accessible :user_id, :description

end