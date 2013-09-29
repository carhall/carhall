module Share
  module Localizable
    extend ActiveSupport::Concern
      
    included do
      belongs_to :location, class_name: Share::Location
    end

    module ClassMethods
      def with_location lat, lng, set_location=true, locations={}
        lat = lat.to_f
        lng = lng.to_f

        geo_hash = Geohash.encode(lat, lng, 5)
        geo_bbox = Geohash.neighbors(geo_hash) << geo_hash
        sql_where_query = geo_bbox.map{|g|"locations.geohash LIKE '#{g}%'"}.join(' or ')
        
        Share::Location.where(sql_where_query).each do |location|
          location.set_distance lat, lng
        end.sort do |location|
          location.distance
        end.each do |location|
          locations[location.id] = location
        end

        records = where(location_id: locations.keys)
        records = records.order("FIELD(location_id, #{locations.keys.join(',')})") if locations.any?
        
        if set_location
          records.includes_values.delete :location
          set_location locations
        end
        
        records
      end

      def set_location locations
        records = scoped
        records.each do |record|
          record.location = locations[record.location_id]
        end
        records
      end
    end
  end
end