class Bcst::Exposure < Share::Comment
  default_scope { order('id DESC') }
  
end