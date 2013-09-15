class Api::ConstantsController < Api::ApplicationController
  Constants = {
    sexes: Accounts::UserDetail::Sexes,
    areas: Share::Areable::Areas,
    brands: Share::Brandable::Brands,
    dealer_types: Accounts::DealerDetail::DealerTypes,
    business_scopes: Accounts::DealerDetail::BusinessScopes,
    cleaning_types: Cleaning::CleaningTypes,
    mending_types: Tips::MendingOrderDetail::MendingTypes,
    bulk_purchasing_types: BulkPurchasing::BulkPurchasingTypes,
  }

  def index
    render_data Constants
  end

  def show
    render_data Constants[params[:id].to_sym]
  end
end