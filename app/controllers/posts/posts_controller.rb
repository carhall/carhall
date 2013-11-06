class Posts::PostsController < Posts::ApplicationController
  set_resource_class Posts::Post, title: :content

end