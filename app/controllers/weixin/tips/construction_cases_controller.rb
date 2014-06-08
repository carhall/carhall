class Weixin::Tips::ConstructionCasesController < Weixin::ApplicationController
  set_resource_class ::Tips::ConstructionCase, shallow: true
  before_filter :unset_dealer

private

  def unset_dealer
    @construction_cases.where_values.delete_if do |query|
      query.left.name == 'dealer_id'
    end unless params[:dealer_id]
  end

end