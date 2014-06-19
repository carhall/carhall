class Weixin::Tips::BuyingAdvicesController < Weixin::ApplicationController
  before_filter :authenticate_weixin_account!
  before_filter :set_weixin_current_user
  before_filter :load_buying_advice
  before_filter :load_area_and_brand

  def show
    redirect_to weixin_brand2s_path unless @buying_advice
  end

  def edit
    @buying_advice ||= @user.build_buying_advice
  end

  def update
    @buying_advice ||= @user.create_buying_advice

    if @buying_advice.update_attributes params.require(:tips_buying_advice)
      .permit(:brand3_id, :buying_at_id, :buying_pattern_id, :license)
      flash[:success] = "您成功设置了 询价请求 。"
      redirect_to action: :show
    else
      render :edit
    end
  end
  alias_method :create, :update

  def destroy
    @buying_advice.destroy
    redirect_to action: :show
  end

private

  def load_buying_advice
    @buying_advice = @user.buying_advice
  end

  def load_area_and_brand
    @main_area_id = params[:area_id]
    @brand2_id = params[:brand2_id]
  end

end