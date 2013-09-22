module Share
  module Localizable
    extend ActiveSupport::Concern
      
    included do
      belongs_to :dealer_detail, class_name: Accounts::DealerDetail
      before_save do
        self.dealer_detail_id = dealer.detail_id
      end

      attr_accessor :distance
    end
    
    module ClassMethods
      def with_location lat, lng
        distance = {}
        detail_ids = Accounts::DealerDetail.where(latitude: (lat-0.1..lat+0.1), longitude: (lng-0.1..lng+0.1)).pluck(:id)
        where(dealer_detail_id: detail_ids).sort do |resource|
          dealer_detail.latitude**2 + dealer_detail.longitude**2
        end
      end

      def with_area area
        area_id = Share::Areable.get_id area
        detail_ids = Accounts::DealerDetail.where(area_id: area_id).pluck(:id)
        where(dealer_detail_id: detail_ids)
      end
    end
  end
end