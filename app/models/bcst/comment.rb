class Bcst::Comment < Share::Comment
  default_scope { order('id DESC') }

end
