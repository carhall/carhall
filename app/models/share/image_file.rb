module Share
  module ImageFile
    URLPrefix = ""

    def define_image_methods attr_name
      attr_name = attr_name.to_s
      class_eval <<-EOM
        has_attached_file :#{attr_name}, styles: { medium: "300x200>", thumb: "60x60>" }
        
        def #{attr_name}_url
          "#{URLPrefix}" + #{attr_name}.url(:original)
        end

        def #{attr_name}_thumb_url
          "#{URLPrefix}" + #{attr_name}.url(:thumb)
        end
      EOM
    end
  end
end