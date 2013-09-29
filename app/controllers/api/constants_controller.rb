class Api::ConstantsController < Api::ApplicationController
  def constants
    {
      sexes: Accounts::UserDetail::Sexes,
      areas: Share::Area.names,
      brands: Share::Brand.names,
      dealer_types: Accounts::DealerDetail::DealerTypes,
      business_scopes: Accounts::DealerDetail::BusinessScopes,
      cleaning_types: Cleaning::CleaningTypes,
      mending_types: ::Tips::MendingOrderDetail::MendingTypes,
      bulk_purchasing_types: ::BulkPurchasing::BulkPurchasingTypes,
    }
  end

  def index
    render_data Constants
  end

  def show
    render_data Constants[params[:id].to_sym]
  end
end