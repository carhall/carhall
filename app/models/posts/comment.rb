class Posts::Comment < Share::Comment
  belongs_to :source, polymorphic: true, counter_cache: :comments_count

end
