class Tips::ConstructionCase < ActiveRecord::Base
  include Share::Distributorable
  include Share::Dealerable

  has_attached_file :image, styles: { medium: "300x200#", thumb: "60x60#" }
  validates_presence_of :image, :product_id

  enumerate :product, with: Category::Product

  before_create do
    self.title = File.basename(image_file_name, '.*').sub(/-[[:xdigit:]]{32}\z/, '').tr('-_', ' ').capitalize if self.title.blank?
  end

end
