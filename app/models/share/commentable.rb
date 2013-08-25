module Share
  module Commentable
    extend ActiveSupport::Concern
      
    included do
      has_many :comments, as: :source
    end

  end
end