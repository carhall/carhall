module Share
  module ImageAttachments
    def define_avatar_method options={}
      has_attached_file :avatar, { styles: { medium: "300x300#", thumb: "60x60#" }}.merge(options)
    end

    def define_image_method options={}
      has_attached_file :image, { styles: { medium: "300x200#", thumb: "60x60#" }}.merge(options)
    end
  end
end