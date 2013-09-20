module Share
  module Localizable
    extend ActiveSupport::Concern
      
    included do
      attr_accessor :distance
    end
    
    module ClassMethods
      def with_location lat, lng
        distance = {}
        dealers = Dealer.with_location(lat, lng).sort do |dealer|
          distance[dealer.id] = dealer.detail.latitude**2 + dealer.detail.longitude**2
        end
        where(dealer_id: dealers).sort do |resource|
          distance[resource.dealer_id]
        end
      end
    end
  end
end