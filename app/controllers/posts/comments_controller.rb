class Posts::CommentsController < Posts::ApplicationController
  load_resource :post, class: Posts::Post
  set_resource_class Posts::Club, through: :post, shallow: true

end