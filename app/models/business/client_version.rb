class Business::ClientVersion < ActiveRecord::Base
  enumerate :client_type, with: %w(iOS Android)

  has_attached_file :file
  validates_presence_of :file, :version, :client_type_id

  def title
    "#{client_type} #{version}"
  end

  scope :apk, -> { with_client_type('Android') }
  scope :latest, -> { order(:version).last }

  after_commit do
    case client_type
    when 'Android'
      $apk_vesion = ::Business::ClientVersion.apk.latest
    when 'iOS'
      
    end
  end

  def download_url
    "#{AbsoluteUrlPrefix}#{file.url(:original, timestamp: false)}"
  end

end