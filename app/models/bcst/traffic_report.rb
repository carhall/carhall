class Bcst::TrafficReport < Share::Comment
  default_scope { order('id DESC') }
  
end