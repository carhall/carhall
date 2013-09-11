class Api::ConstantsController < Api::ApplicationController
  Constants = {
    sexes: Accounts::ConsumerDetail::Sexes,
    areas: Share::Areable::Areas,
    brands: Share::Brandable::Brands,
    dealer_types: Accounts::DealerDetail::DealerTypes,
    business_scopes: Accounts::DealerDetail::BusinessScopes,
    cleaning_types: ::Tips::Cleaning::CleaningTypes,
    bulk_purchasing_types: ::Tips::BulkPurchasing::BulkPurchasingTypes,
  }

  def index
    render_data Constants
  end

  def show
    render_data Constants[params[:id].to_sym]
  end
end