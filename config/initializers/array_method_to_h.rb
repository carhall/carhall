Array.class_eval do
  
  def to_h
    Hash[self]
  end

end