class Api::ConstantsController < Api::ApplicationController
  skip_before_filter :authenticate_account!

  def constants
    {
      sexes: ::Accounts::Account::Sex.all,
      areas: Category::Area.all,
      brands: Category::Brand.all.map{|r|[r.id, r.name]},
      dealer_types: ::Accounts::DealerDetail::DealerType.all,
      business_scopes: ::Accounts::DealerDetail::BusinessScope.all,
      cleaning_types: ::Tips::Cleaning::CleaningType.all,
      mending_types: ::Tips::MendingOrderDetail::MendingType.all,
      bulk_purchasing_types: ::Tips::BulkPurchasing::BulkPurchasingType.all,
      specific_services: ::Accounts::DealerDetail::SpecificService.all,
    }
  end

  def index
    render_data constants
  end

  def show
    render_data constants[params[:id].to_sym]
  end
end