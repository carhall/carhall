module Accounts::RqrcodeTokenable
  extend ActiveSupport::Concern

  included do
    after_create :generate_rqrcode_token!
  end

  # Generate a token by looping and ensuring does not already exist.
  def generate_rqrcode_token
    # loop do
    #   token = Devise.friendly_token
    #   unless detail.class.where(rqrcode_token: token).exists?
    #     detail.rqrcode_token = token
    #     generate_rqrcode_image token
    #     break token
    #   end
    # end
    "qichetang:#{id}"
  end

  def generate_rqrcode_image string=nil, options={}
    string ||= detail.rqrcode_token
    size   = options[:size]  || RQRCode.minimum_qr_size_from_string(string)
    level  = options[:level] || :h

    qrcode = RQRCode::QRCode.new(string, :size => size, :level => level)
    svg    = RQRCode::Renderers::SVG::render(qrcode, options)

    image = MiniMagick::Image.read(svg) { |i| i.format :svg }
    image.format :png
    detail.rqrcode_image = File.open(image.path)
  end

  def generate_rqrcode_token!
    generate_rqrcode_token && detail.save(validate: false)
  end

  def ensure_rqrcode_token!
    generate_rqrcode_token! unless detail.rqrcode_token
  end

  def generate_rqrcode_image!
    generate_rqrcode_image && detail.save(validate: false)
  end

  def ensure_rqrcode_image!
    generate_rqrcode_image! unless detail.rqrcode_image.present?
  end

end