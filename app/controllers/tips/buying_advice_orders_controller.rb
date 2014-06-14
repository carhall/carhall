class Tips::BuyingAdviceOrdersController < Tips::ApplicationController
  load_resource :buying_advice, class: Tips::BuyingAdvice
  set_resource_class Tips::BuyingAdviceOrder, through: :buying_advice, shallow: true

  def after_create_path
    tips_buying_advices_path
  end
  def after_update_path
    tips_buying_advices_path
  end

  def tips_buying_advice_order_params
    params.require(:tips_buying_advice_order).permit(:price, :description, :adviser,
      :buying_advice_id)
  end

end
