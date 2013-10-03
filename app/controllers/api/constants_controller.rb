class Api::ConstantsController < Api::ApplicationController
  def constants
    {
      sexes: ::Accounts::UserDetail::Sex.all,
      areas: Share::Area.all,
      brands: Share::Brand.all,
      dealer_types: ::Accounts::DealerDetail::DealerType.all,
      business_scopes: ::Accounts::DealerDetail::BusinessScope.all,
      cleaning_types: ::Tips::Cleaning::CleaningType.all,
      mending_types: ::Tips::MendingOrderDetail::MendingType.all,
      bulk_purchasing_types: ::Tips::BulkPurchasing::BulkPurchasingType.all,
    }
  end

  def index
    render_data constants
  end

  def show
    render_data constants[params[:id].to_sym]
  end
end