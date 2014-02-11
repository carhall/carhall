class Tips::VipCardsController < Tips::ApplicationController
  set_resource_class ::Tips::VipCard

  alias_method :reenable, :expose
  alias_method :disable, :hide

  after_filter :check_upload, only: [:create, :update]

  def check_upload
    if @vip_card.valid? && @upload.present?
      upload_success = 0
      upload_fails = []

      sheet = Spreadsheet.open(@upload.tempfile.path).worksheet(0)
      sheet.each 2 do |row|
        begin
          user = Accounts::User.find_by mobile: row[0].to_i

          order = @vip_card.orders.create user: user
          order.enable
          order.items.each_with_index do |item, index|
            item.use row[index+1].to_i
          end
          order.save!
          
          upload_success += 1
        rescue
          upload_fails << row[0].to_i
        end
      end

      flash[:warning] = "总计#{upload_success}条会员卡记录导入成功，#{upload_fails.size}条导入失败。"
      flash[:warning] += "请检查以下几条客户的数据：#{upload_fails.join('、')}" if upload_fails.any?
    end
  end

  def tips_vip_card_params
    @upload = params.require(:tips_vip_card)[:upload]
    params.require(:tips_vip_card).permit(:title, :vip_price, :price, :description, :image, 
      vip_card_items_attributes: [:id, :_destroy, :title, :count])
  end

end
