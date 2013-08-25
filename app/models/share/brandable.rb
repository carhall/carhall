module Share
  module Brandable
    extend ActiveSupport::Concern

    Brands = [
      "",
    ]

    def brand
      return I18n.t('.unknown') unless brand_id
      Brands[brand_id]
    end

    def brand= brand
      self.brand_id = Brands.index brand
    end

  end
end