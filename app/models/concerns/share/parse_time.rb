module Share::ParseTime
  def define_parse_time_method attr_name
    validates_each attr_name do |record, attr, value|
      record.errors.add(attr, :invalid) if value.kind_of? Symbol
    end

    class_eval <<-EOM
      def #{attr_name}= time
        return super time if time.kind_of? Time or time.kind_of? Date
        super Time.parse time
      rescue
        super time.to_sym
      end
    EOM
  end

end
