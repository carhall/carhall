class Category::Product < ActiveRecord::Base
  Products = []

  include Share::Categoryable

end