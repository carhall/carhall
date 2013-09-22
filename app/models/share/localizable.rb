module Share
  module Localizable
    extend ActiveSupport::Concern
      
    included do
      belongs_to :dealer_detail, class_name: Accounts::DealerDetail
      before_save do
        self.dealer_detail_id = dealer.detail_id
      end

      default_scope { order('id DESC') }
      attr_accessor :distance
    end
      
    def detail_hash
      detail_hash = {}
      detail_hash[:goal_attainment] = goal_attainment
      detail_hash[:last_3_orders] = orders.includes(:user).last(3)
      detail_hash[:last_3_reviews] = reviews.includes(order: :user).last(3)
      serializable_hash(include: {dealer: {include: :detail}}).merge(detail: detail_hash)
    end

    module ClassMethods
      def with_location lat, lng
        lat_range = (lat.to_f-0.1)..(lat.to_f+0.1)
        lng_range = (lng.to_f-0.1)..(lng.to_f+0.1)
        
        distance = {}
        detail_ids = Accounts::DealerDetail.where(latitude: lat_range, longitude: lng_range).pluck(:id)
        includes(:dealer_detail).where(dealer_detail_id: detail_ids).sort do |r|
          distance[r.dealer_detail] ||= Math.sqrt((r.dealer_detail.latitude-lat)**2 + (r.dealer_detail.longitude-lng)**2)
          r.distance = distance[r.dealer_detail]
        end
      end

      def with_area area
        area_id = Share::Areable.get_id area
        detail_ids = Accounts::DealerDetail.where(area_id: area_id).pluck(:id)
        where(dealer_detail_id: detail_ids)
      end

      def cheapie
        order('cost ASC')
      end

      def favorite
        scoped.sort{|s|s.stars}
      end

      def hot
        order('orders_count DESC')
      end
    end
  end
end