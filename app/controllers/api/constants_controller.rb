class Api::ConstantsController < Api::ApplicationController
  Constants = {
    sexes: Auth::UserDetail::Sexes,
    areas: Share::Areable::Areas,
    brands: Share::Brandable::Brands,
    dealer_types: Auth::DealerDetail::DealerTypes,
    business_scopes: Auth::DealerDetail::BusinessScopes,
    cleaning_types: Cleaning::CleaningTypes,
    bulk_purchasing_types: BulkPurchasing::BulkPurchasingTypes,
  }

  def index
    render_data Constants
  end

  def show
    render_data Constants[params[:id].to_sym]
  end
end