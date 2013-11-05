class Api::ConstantsController < Api::ApplicationController
  skip_before_filter :authenticate_account_from_token!

  def constants
    {
      sexes: ::Accounts::Account::Sex.all,
      areas: ::Category::Area.all,
      brands: ::Category::Brand.all.map{|b|[b.id, b.name]},
      dealer_types: ::Accounts::DealerDetail::DealerType.all,
      business_scopes: ::Accounts::DealerDetail::BusinessScope.all,
      cleaning_types: ::Tips::Cleaning::CleaningType.all,
      mending_types: ::Tips::MendingOrderDetail::MendingType.all,
      bulk_purchasing_types: ::Tips::BulkPurchasing::BulkPurchasingType.all,
      profession_types: ::Accounts::DealerDetail::SpecificService.all,
    }
  end

  def index
    render_data constants
  end

  def show
    render_data constants[params[:id].to_sym]
  end

  def brands
    render_data ::Category::Brand.all
  end

  def version
    $apk_vesion ||= ::Business::ClientVersion.apk_latest
    if params[:version].to_i < $apk_vesion.version
      render_data update: true, download_url: $apk_vesion.download_url
    else
      render_data update: false
    end
  end
end