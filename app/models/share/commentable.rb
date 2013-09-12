module Share
  module Commentable
    extend ActiveSupport::Concern
      
    included do
      has_many :comments
    end

  end
end