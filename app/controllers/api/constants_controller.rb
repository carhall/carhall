class Api::ConstantsController < Api::ApplicationController
  def constants
    {
      sexes: ::Accounts::Account::Sex.names,
      areas: Category::Area.names,
      brands: Category::Brand.names,
      dealer_types: ::Accounts::DealerDetail::DealerType.names,
      business_scopes: ::Accounts::DealerDetail::BusinessScope.names,
      cleaning_types: ::Tips::Cleaning::CleaningType.names,
      mending_types: ::Tips::MendingOrderDetail::MendingType.names,
      bulk_purchasing_types: ::Tips::BulkPurchasing::BulkPurchasingType.names,
      specific_services: ::Accounts::DealerDetail::SpecificService.names,
    }
  end

  def index
    render_data constants
  end

  def show
    render_data constants[params[:id].to_sym]
  end
end