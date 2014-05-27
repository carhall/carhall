class Tips::ManualImage < ActiveRecord::Base
  include Share::Distributorable

  has_attached_file :image, styles: { medium: "300x200^", thumb: "60x60#" }

  validates_presence_of :image, :category

  before_create do
    self.title = File.basename(image_file_name, '.*').sub(/-[[:xdigit:]]{32}\z/, '').tr('-_', ' ').capitalize if self.title.blank?
  end

end
